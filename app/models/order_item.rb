class OrderItem < ActiveRecord::Base
  attr_accessible :item_id, :order_id, :qty
  belongs_to :item
  belongs_to :order

  validates :item_id, presence: true
  validates :order_id, presence: true
  validates_uniqueness_of :item_id, :scope => [:order_id]

  def price
     item.price * qty
  end
end
