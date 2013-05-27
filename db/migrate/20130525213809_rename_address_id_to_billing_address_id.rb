class RenameAddressIdToBillingAddressId < ActiveRecord::Migration
  def up
    rename_column :payments, :address_id, :billing_address_id
  end

  def down
  end
end
