FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "Item #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    sequence(:price) { |n| "#{n}.0" }
  end

  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@da-silva.me.uk" }
    password "foobar"
    password_confirmation "foobar"
  end
end
