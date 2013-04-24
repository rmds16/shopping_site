class Address < ActiveRecord::Base
  attr_accessible :user_id, :building, :city, :country, :county, :first_name, :last_name, :organisation, :phone, :post_code, :street, :title, :town
  belongs_to :user
  has_many :orders
  has_many :payments

  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :building, presence: true
  validates :street, presence: true
  validates :county, presence: true
  validates :post_code, presence: true
  validates :town, presence: true
  validates :country, presence: true
end
