class AddNotesToCodAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :cod_accounts, :notes, :text
  end
end
