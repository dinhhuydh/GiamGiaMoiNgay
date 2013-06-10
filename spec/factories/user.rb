FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@giamgiamoingay.com" }
    password "123456789"
    password_confirmation { |u| u.password }
  end
end
