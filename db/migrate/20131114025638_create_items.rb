class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.string :details
      t.integer :qty_current
      t.integer :qty_ideal
      t.integer :qty_sold
      t.float :avg_sales
      t.string :supplier
      t.datetime :exp_date
      t.datetime :pur_date

      t.timestamps
    end
  end
end
