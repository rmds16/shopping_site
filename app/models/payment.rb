class Payment < ActiveRecord::Base
  attr_accessor :verification_value, :existing_address
  attr_accessible :card_type, :expiry_date, :billing_address_id, :card_number, :verification_value, :existing_address
  belongs_to :billing_address
  belongs_to :order

  validates :card_number, presence: true
  validates :verification_value, presence: true
  validates :card_type, presence: true
  validates :expiry_date, presence: true

  def purchase price_in_pence
      if self.order.stage == 1
        return true
      end
      # process payment
      credit_card = ActiveMerchant::Billing::CreditCard.new(
                                                            :first_name         => self.billing_address.first_name,
                                                            :last_name          => self.billing_address.last_name,
                                                            :number             => self.card_number,
                                                            :brand              => self.card_type,
                                                            :month              => self.expiry_date.month,
                                                            :year               => self.expiry_date.year,
                                                            :verification_value => self.verification_value
                                                           )
      if credit_card.valid?
        response = GATEWAY.purchase(price_in_pence, credit_card)
        unless response.success?
          self.errors.add :base, "Card Declined"
          return false
        end
        self.card_number = credit_card.display_number
        self.order.stage = 1
        self.order.save
        response.success? 
      else
        credit_card.errors.full_messages.each do |message|
          self.errors.add :base, message
        end
        false
      end
  end 
end
