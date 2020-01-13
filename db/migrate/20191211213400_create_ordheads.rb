class CreateOrdheads < ActiveRecord::Migration[5.1]
  def change
    create_table :ordheads do |t|
      t.string :order_numb
      t.string :rel_numb
      t.string :cost_ctr
      t.string :cust_name
      t.string :route_code
      t.string :cust_code

      t.timestamps
    end
  end
end
