class CreateCodAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :cod_accounts do |t|
      t.date :ship_date
      t.string :invoice_numb
      t.string :route_code
      t.string :cust_code
      t.string :cust_name
      t.string :cost_ctr
      t.datetime :logistics_complete_date
      t.datetime :accounting_complete_date
      t.string :reason_code
      t.string :reason_details
      t.boolean :logistics_completed
      t.boolean :accounting_completed
      t.string :logistics_agent
      t.string :received_as
      t.float :amount_owed
      t.float :amount_extra
      t.float :amount_received
      t.float :amount_credit
      t.float :credit_amount

      t.timestamps
    end
  end
end
