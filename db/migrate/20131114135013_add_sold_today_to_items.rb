class AddSoldTodayToItems < ActiveRecord::Migration
  def change
    add_column :items, :sold_today, :integer
  end
end
