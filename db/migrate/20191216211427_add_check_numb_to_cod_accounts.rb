class AddCheckNumbToCodAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :cod_accounts, :check_numb, :string
  end
end
