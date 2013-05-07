class Order < ActiveRecord::Base
  attr_accessor :existing_address
  attr_accessible :address_id, :existing_address
  belongs_to :address
  has_one :payment
  belongs_to :user
  has_many :order_items
  accepts_nested_attributes_for :address

  validates :address_id, :presence => true
  validates :user_id, :presence => true

  def add_item(item_id)
    current_item = order_items.where(:item_id => item_id).first
    if current_item
      current_item.qty += 1
    else
      current_item = order_items.build(:item_id => item_id)
    end
    current_item
  end

  def price
    total_price = 0
    order_items.includes(:item).each do |order_item|
      total_price += order_item.price
    end
    total_price
  end

  def price_in_pence
    price*100
  end

  def item_qty
    total_qty = 0
    order_items.includes(:item).each do |order_item|
      total_qty += order_item.qty
    end
    total_qty
  end

end
