class CreateInvheads < ActiveRecord::Migration[5.1]
  def change
    create_table :invheads do |t|
      t.string :invoice_numb
      t.string :order_numb
      t.string :rel_numb
      t.date :ship_date

      t.timestamps
    end
  end
end
