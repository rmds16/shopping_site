class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :address_id
      t.integer :stage, :default => 0
      t.integer :user_id

      t.timestamps
    end
  end
end
