class Basket < ActiveRecord::Base
  has_many :basket_items, :dependent => :destroy

  def add_item(item_id)
    current_item = basket_items.where(:item_id => item_id).first
    if current_item
      current_item.qty += 1
    else
      current_item = basket_items.build(:item_id => item_id)
    end
    current_item
  end

  def price
    total_price = 0
    basket_items.each do |basket_item|
      total_price += basket_item.price
    end
    total_price
  end
end