FactoryGirl.define do
  factory :product do
    sequence(:name) {|n| "product #{n}" }
    price { "#{rand(10) + 1}000000".to_i }
    sale_by_day { "#{rand(10) + 1}00000".to_i }
    public_time { Time.now }
    initial_price { "#{rand(10) + 11}000000".to_i }
  end
end
