class AddCodRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cod_role, :string
  end
end
