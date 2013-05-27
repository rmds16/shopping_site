class RenameAddressIdToDeliveryAddressId < ActiveRecord::Migration
  def up
    rename_column :orders, :address_id, :delivery_address_id
  end

  def down
  end
end
