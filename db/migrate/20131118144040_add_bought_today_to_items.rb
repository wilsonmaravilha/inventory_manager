class AddBoughtTodayToItems < ActiveRecord::Migration
  def change
    add_column :items, :bought_today, :integer
  end
end
