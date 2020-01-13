require 'test_helper'

class CodAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cod_account = cod_accounts(:one)
  end

  test "should get index" do
    get cod_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_cod_account_url
    assert_response :success
  end

  test "should create cod_account" do
    assert_difference('CodAccount.count') do
      post cod_accounts_url, params: { cod_account: { accounting_complete_date: @cod_account.accounting_complete_date, accounting_completed: @cod_account.accounting_completed, amount_credit: @cod_account.amount_credit, amount_extra: @cod_account.amount_extra, amount_owed: @cod_account.amount_owed, amount_received: @cod_account.amount_received, cost_ctr: @cod_account.cost_ctr, credit_amount: @cod_account.credit_amount, cust_code: @cod_account.cust_code, cust_name: @cod_account.cust_name, invoice_numb: @cod_account.invoice_numb, logistics_agent: @cod_account.logistics_agent, logistics_complete_date: @cod_account.logistics_complete_date, logistics_completed: @cod_account.logistics_completed, reason_code: @cod_account.reason_code, reason_details: @cod_account.reason_details, received_as: @cod_account.received_as, route_code: @cod_account.route_code, ship_date: @cod_account.ship_date } }
    end

    assert_redirected_to cod_account_url(CodAccount.last)
  end

  test "should show cod_account" do
    get cod_account_url(@cod_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_cod_account_url(@cod_account)
    assert_response :success
  end

  test "should update cod_account" do
    patch cod_account_url(@cod_account), params: { cod_account: { accounting_complete_date: @cod_account.accounting_complete_date, accounting_completed: @cod_account.accounting_completed, amount_credit: @cod_account.amount_credit, amount_extra: @cod_account.amount_extra, amount_owed: @cod_account.amount_owed, amount_received: @cod_account.amount_received, cost_ctr: @cod_account.cost_ctr, credit_amount: @cod_account.credit_amount, cust_code: @cod_account.cust_code, cust_name: @cod_account.cust_name, invoice_numb: @cod_account.invoice_numb, logistics_agent: @cod_account.logistics_agent, logistics_complete_date: @cod_account.logistics_complete_date, logistics_completed: @cod_account.logistics_completed, reason_code: @cod_account.reason_code, reason_details: @cod_account.reason_details, received_as: @cod_account.received_as, route_code: @cod_account.route_code, ship_date: @cod_account.ship_date } }
    assert_redirected_to cod_account_url(@cod_account)
  end

  test "should destroy cod_account" do
    assert_difference('CodAccount.count', -1) do
      delete cod_account_url(@cod_account)
    end

    assert_redirected_to cod_accounts_url
  end
end
