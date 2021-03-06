class CodAccountsController < ApplicationController
  before_action :set_cod_account, only: [:show, :edit, :update, :destroy]
  before_action :set_drop_downs, only: [:new, :edit, :update, :create]

  # GET /cod_accounts
  def index

    if params[:cost_ctr] || params[:ship_date]
      # looks like something may have changed
      @cc = params[:cost_ctr]
      if params[:ship_date]
        @ship_date = params[:ship_date].to_date
        ship_date = params[:ship_date] + ' 05:00:00'
        session[:ship_date] = ship_date.to_date
      else
        @ship_date = Date.current
        session[:ship_date] = Date.current
      end
      session[:cc] = params[:cost_ctr]
    end
    if current_user.cod_role != 'Accounting'
      invoices = Invhead.where(cost_ctr: session[:cc]).where("ship_date = ?", session[:ship_date]).where("terms_code LIKE :prefix", prefix: "COD%")
      invoices.each do |i|
        # create cod_account records for this cost center and ship date if they don't already exist
        if i.order_numb != "MISC"
          ca = CodAccount.find_by invoice_numb: i.invoice_numb
          if !ca
            # there is no existing COD record so create one with initial values
            codaccount = CodAccount.new
            codaccount.invoice_numb = i.invoice_numb
            codaccount.ship_date = i.ship_date
            invview = Invheadview.find_by invoice_numb: i.invoice_numb
            if invview
              if !invview.sub_total
                invview.sub_total = 0
              end
              if !invview.charged_frt
                invview.charged_frt = 0
              end
              codaccount.amount_owed = (invview.sub_total + invview.charged_frt).round(2)
            else
              codaccount.amount_owed = 0
            end
            ordhead = Ordhead.find_by order_numb: i.order_numb, rel_numb: i.rel_numb
            if ordhead
              codaccount.route_code = ordhead.route_code
              if codaccount.route_code.length == 1
                # need to prefix 1 digit route codes with blank to make them sort correctly
                codaccount.route_code.insert(0, '0')
              end
              codaccount.cust_code = ordhead.cust_code
              codaccount.cust_name = ordhead.cust_name
              codaccount.cost_ctr = ordhead.cost_ctr
              codaccount.logistics_completed = false
              codaccount.accounting_completed = false
              codaccount.save(:validate => false)
            end
          end
        end
      end
    end
    case current_user.cod_role
    when 'Admin'
      # show all the COD records for this CC and shipping date
      @cod_accounts = CodAccount.where(cost_ctr: session[:cc]).where("ship_date = ?", session[:ship_date])
    when 'Logistics'
      # show all the COD records for this CC and shipping date
      @cod_accounts = CodAccount.where(cost_ctr: session[:cc]).where("ship_date = ?", session[:ship_date])
    else
      # must be accounting
      # show all the COD records for this CC  completed by logistics but not completed by accounting
      @cod_accounts = CodAccount.where(cost_ctr: session[:cc]).where(logistics_completed: true).where.not(accounting_completed: true)
    end
  end

  # GET /cod_accounts for accounting
  def accounts

    if params[:cost_ctr]
      # looks like something may have changed
      @cc = params[:cost_ctr]
      session[:cc] = params[:cost_ctr]
    end
    @cod_accounts = CodAccount.where(cost_ctr: session[:cc]).where(logistics_completed: true).where.not(accounting_completed: true)
  end

  def verified
    i = 0
    cod_count = CodAccount.where(cost_ctr: session[:cc]).where(logistics_completed: true).where.not(accounting_completed: true).length
    while i < cod_count
      i += 1
      verifiedi = 'verified'+i.to_s
      if params[verifiedi] == '1'
        # check box selected
        idi = 'id'+i.to_s
        cod_account = CodAccount.find_by id: params[idi]
        cod_account.accounting_completed = true
        cod_account.accounting_complete_date = Date.current
        cod_account.save
      end
    end
    redirect_to cod_accounts_accounts_path, notice: 'CODs were successfully verified.'
  end

  # GET /cod_accounts/1
  def show
  end

  # GET /cod_accounts/new
  def new
    @cod_account = CodAccount.new
  end

  # GET /cod_accounts/1/edit
  def edit
  end

  # POST /cod_accounts
  def create
    @cod_account = CodAccount.new(cod_account_params)

    respond_to do |format|
      if @cod_account.save
        format.html { redirect_to cod_accounts_url, notice: 'COD account was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /cod_accounts/1
  def update
    respond_to do |format|
      if @cod_account.update(cod_account_params)
        if @cod_account.logistics_completed && current_user.cod_role == 'Logistics'
          # Just completed by logistics, store the user id
          @cod_account.logistics_agent = current_user.email
          @cod_account.logistics_complete_date = DateTime.now
          @cod_account.save
        end
        if @cod_account.accounting_completed && current_user.cod_role == 'Accounting'
          # Just completed by accounting, store the user id
          @cod_account.accounting_complete_date = DateTime.now
          @cod_account.save
        end
        format.html { redirect_to cod_accounts_url, notice: 'COD account was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /cod_accounts/1
  def destroy
    @cod_account.destroy
    respond_to do |format|
      format.html { redirect_to cod_accounts_url, notice: 'COD account was successfully deleted.' }
    end
  end

  def cc_date
    if !user_signed_in? || !current_user.cod
      redirect_to signout_path and return
    else
      if !session[:ship_date]
        session[:ship_date] = Date.current
      end
      @ship_date = session[:ship_date]
      # @ship_date = session[:ship_date].strftime('%Y-%m-%d')
      @ccs = ['NJ', 'IL', 'GA', 'TX', 'CO']
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cod_account
      @cod_account = CodAccount.find(params[:id])
    end

    def set_drop_downs
      @reasons = ["Driver Error",
      "Drop Approved by Credit",
      "Drop Approved by Regional Manager",
      "Returned - Credit in process",
      "Short Paid - Pricing issue - Sales to investigate",
      "Short Paid - Product missing - Credit pending"]
      @received_as = ["Cash", "Check"]
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def cod_account_params
      params.require(:cod_account).permit(:ship_date, :invoice_numb, :route_code, :cust_code, :cust_name, :cost_ctr, :logistics_complete_date,
        :accounting_complete_date, :reason_code, :reason_details, :logistics_completed, :accounting_completed, :logistics_agent, :received_as,
        :amount_owed, :amount_extra, :amount_received, :amount_credit, :credit_amount, :check_numb, :notes)
    end
end
