class BillingAddress < Address
  has_many :payments 
  # attr_accessible :title, :body
end
