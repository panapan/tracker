FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :subscriber do
      notify true
    end
  end

  factory :parcel do
    sequence(:num) { |n| "123456789#{n}"}
    user
  end

  factory :track do
    sequence(:track_id) {|n| n}
    parcel
  end
end