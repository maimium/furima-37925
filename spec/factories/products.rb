FactoryBot.define do
  factory :product do
    product_name { '商品の名前' }
    description { '商品の説明' }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    category_id { Faker::Number.between(from: 2, to: 11) }
    condition_id { Faker::Number.between(from: 2, to: 7) }
    delivery_charge_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    delivery_days_id { Faker::Number.between(from: 2, to: 4) }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root,'app/assets/images/star.png'))}

    association :user
  end
end
