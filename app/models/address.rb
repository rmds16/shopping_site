class Address < ActiveRecord::Base
  attr_accessible :user_id, :building, :city, :country, :county, :first_name, :last_name, :organisation, :phone, :post_code, :street, :title, :town
  belongs_to :user
  has_many :orders
  has_many :payments

  VALIDATE_POST_CODE_REGEX= /\A[A-Z]{2}[0-9]{1,2}[\s]*[0-9]{1,2}[A-Z]{2}\z/i
  VALIDATE_PHONE_REGEX= /\A[0-9\+\s]+\z/i
  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :building, presence: true
  validates :street, presence: true
  validates :county, presence: true
  validates :post_code, presence: true, format: { with: VALIDATE_POST_CODE_REGEX }
  validates :town, presence: true
  validates :country, presence: true
  validates :phone, format: { with: VALIDATE_PHONE_REGEX, :allow_blank => true }

private

  def full_address
    "#{self.title} #{self.first_name} #{self.organisation} #{self.building} #{self.street} #{self.town} #{self.county} #{self.post_code} #{self.country}"
  end

end
