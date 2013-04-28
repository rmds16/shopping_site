class Item < ActiveRecord::Base
  attr_accessible :description, :name, :price
  has_many :basket_items

  validates :description, presence: true
  validates :name, presence: true
  validates :price, presence: true
end
