class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.string  :card_type
      t.date    :expiry_date
      t.integer :address_id

      t.timestamps
    end
  end
end
