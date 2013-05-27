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

  factory :address do
    title "Mr"
    sequence(:first_name) { |n| "First name #{n}" }
    sequence(:last_name) { |n| "Last name #{n}" }
    sequence(:organisation) { |n| "Organisation #{n}" }
    sequence(:building) { |n| "Building #{n}" }
    sequence(:street) { |n| "Street #{n}" }
    sequence(:town) { |n| "Town #{n}" }
    sequence(:city) { |n| "City #{n}" }
    sequence(:county) { |n| "County #{n}" }
    post_code "EX41 1PL"
    sequence(:country) { |n| "Country #{n}" }
    phone "07000000000"
  end

  factory :book_address do
    title "Mr"
    sequence(:first_name) { |n| "First name #{n}" }
    sequence(:last_name) { |n| "Last name #{n}" }
    sequence(:organisation) { |n| "Organisation #{n}" }
    sequence(:building) { |n| "Building #{n}" }
    sequence(:street) { |n| "Street #{n}" }
    sequence(:town) { |n| "Town #{n}" }
    sequence(:city) { |n| "City #{n}" }
    sequence(:county) { |n| "County #{n}" }
    post_code "EX41 1PL"
    sequence(:country) { |n| "Country #{n}" }
    phone "07000000000"
  end

  factory :billing_address do
    title "Mr"
    sequence(:first_name) { |n| "First name #{n}" }
    sequence(:last_name) { |n| "Last name #{n}" }
    sequence(:organisation) { |n| "Organisation #{n}" }
    sequence(:building) { |n| "Building #{n}" }
    sequence(:street) { |n| "Street #{n}" }
    sequence(:town) { |n| "Town #{n}" }
    sequence(:city) { |n| "City #{n}" }
    sequence(:county) { |n| "County #{n}" }
    post_code "EX41 1PL"
    sequence(:country) { |n| "Country #{n}" }
    phone "07000000000"
  end

  factory :delivery_address do
    title "Mr"
    sequence(:first_name) { |n| "First name #{n}" }
    sequence(:last_name) { |n| "Last name #{n}" }
    sequence(:organisation) { |n| "Organisation #{n}" }
    sequence(:building) { |n| "Building #{n}" }
    sequence(:street) { |n| "Street #{n}" }
    sequence(:town) { |n| "Town #{n}" }
    sequence(:city) { |n| "City #{n}" }
    sequence(:county) { |n| "County #{n}" }
    post_code "EX41 1PL"
    sequence(:country) { |n| "Country #{n}" }
    phone "07000000000"
  end

  factory :payment do
    card_type "visa"
    card_number "4111111111111111"
    expiry_date "2014-04-10"
    verification_value "111"
    existing_address = "1"
  end
end
