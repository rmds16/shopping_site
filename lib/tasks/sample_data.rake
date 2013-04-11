namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    50.times do |n|
      name = "Item #{n}" 
      description = Faker::Lorem.paragraph
      price = rand(100)
      Item.create!(name: name, description: description, price: price)
    end
  end
end
