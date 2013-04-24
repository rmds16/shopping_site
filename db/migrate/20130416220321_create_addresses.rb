class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :organisation
      t.string :building
      t.string :street
      t.string :town
      t.string :city
      t.string :county
      t.string :post_code
      t.string :country
      t.string :phone

      t.timestamps
    end
  end
end
