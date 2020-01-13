class AddCodToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cod, :boolean
  end
end
