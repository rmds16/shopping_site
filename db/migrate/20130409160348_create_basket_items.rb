class CreateBasketItems < ActiveRecord::Migration
  def change
    create_table :basket_items do |t|
      t.integer :item_id
      t.integer :basket_id

      t.timestamps
    end
  end
end
