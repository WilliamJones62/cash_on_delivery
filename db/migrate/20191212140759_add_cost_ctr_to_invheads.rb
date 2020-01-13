class AddCostCtrToInvheads < ActiveRecord::Migration[5.1]
  def change
    add_column :invheads, :cost_ctr, :string
  end
end
