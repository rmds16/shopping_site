class AddQtyToBasketItems < ActiveRecord::Migration
  def change
    add_column :basket_items, :qty, :integer, :default => 1
  end
end
