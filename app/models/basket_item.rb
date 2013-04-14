class BasketItem < ActiveRecord::Base
  attr_accessible :basket_id, :item_id, :qty
  belongs_to :item
  belongs_to :basket

  validates :item_id, presence: true
  validates :basket_id, presence: true
  validates_uniqueness_of :item_id, :scope => [:basket_id]

  def price
     item.price * qty
  end
end
