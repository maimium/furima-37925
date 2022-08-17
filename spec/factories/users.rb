FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { '1a' / Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    family_name { Gimei.last.kanji }
    family_name_kana { Gimei.last.katakana }
    personal_name { Gimei.first.kanji }
    personal_name_kana { Gimei.first.katakana }
    birthday { Faker::Date.birthday }
  end
end
