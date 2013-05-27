class DeliveryAddress < Address
  has_many :orders
  # attr_accessible :title, :body
end
