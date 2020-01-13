class CreateInvheadviews < ActiveRecord::Migration[5.1]
  def change
    create_table :invheadviews do |t|
      t.string :invoice_numb
      t.string :order_numb
      t.string :rel_numb
      t.date :ship_date
      t.float :sub_total
      t.float :charged_frt

      t.timestamps
    end
  end
end
