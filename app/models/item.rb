class Item < ActiveRecord::Base
  attr_accessible :description, :name, :price
  has_one :basket_item
  has_one :order_item

  validates :description, presence: true
  validates :name, presence: true
  validates :price, presence: true
end
