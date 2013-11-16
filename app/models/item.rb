class Item < ActiveRecord::Base
	validates :name, presence: true
	validates :qty_current, presence: true
	validates :qty_ideal, presence: true
	validates :exp_date, presence: true
	validates :qty_sold, presence: true
	belongs_to :user
end
