FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { '2' }
    municipalities { '足立区' }
    block_number { '1-1' }
    building { '東京ハイツ' }
    phone_number { '09012345678' }
    token {"tok_abcdefghijk00000000000000000"}

    association :user
    association :item
  end
end
