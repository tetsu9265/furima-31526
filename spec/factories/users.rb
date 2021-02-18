FactoryBot.define do
  factory :user do
    transient do
      person              {Gimei.name}
    end
    nickname              {Faker::Name.name}
    email                 {Faker::Internet.free_email}
    password              {Faker::Lorem.characters(min_alpha: 1, min_numeric: 1, number: 6)}
    password_confirmation {password}
    family_name           {person.last.kanji}
    given_name            {person.first.kanji}
    family_name_kana      {person.last.katakana}
    given_name_kana       {person.first.katakana}
    birthday              {Faker::Date.between(from: '1930-01-01', to:Date.today-365 * 5)}
  end
end