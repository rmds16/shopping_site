FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "Item #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    sequence(:price) { |n| "#{n}.0" }
  end
end
