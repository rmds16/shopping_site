class Payment < ActiveRecord::Base
  attr_accessor :card_number, :verification_value, :existing_address
  attr_accessible :card_type, :expiry_date, :address_id, :card_number, :verification_value, :existing_address
  belongs_to :address
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
                                                            :first_name         => self.address.first_name,
                                                            :last_name          => self.address.last_name,
                                                            :number             => self.card_number,
                                                            :type               => self.card_type,
                                                            :month              => self.expiry_date.month,
                                                            :year               => self.expiry_date.year,
                                                            :verification_value => self.verification_value
                                                           )
      if credit_card.valid?
        response = GATEWAY.purchase(price_in_pence, credit_card)
        self.card_number = credit_card.display_number
        unless response.success?
          self.errors.add :base, "Card Declined"
        end
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
