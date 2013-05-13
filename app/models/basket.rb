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

  def remove_item(current_item)
    if current_item.qty == 1
      current_item.destroy
    else
      current_item.qty -= 1
      current_item.save
    end
  end

  def vat
    vat = 0
    basket_items.each do |basket_item|
      vat += basket_item.price * 0.2
    end
    vat
  end

  def price
    total_price = 0
    basket_items.each do |basket_item|
      total_price += basket_item.price * 1.2
    end
    total_price
  end
end
