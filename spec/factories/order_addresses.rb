FactoryBot.define do
  factory :order_address do
    transient do
      person { Gimei.name }
    end

    post_code { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { Gimei.address.city.kanji }
    house_number { Gimei.address.town.kanji }
    building { '建物名' }
    phone_number { Faker::Number.number(digits: 10,digits: 11) }
    token { 'qwertyuiopasdfghjkl1234' }
  end
end
