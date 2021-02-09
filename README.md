# テーブル設計

## users テーブル

| Column            | Type   | Options                   |
|-------------------|--------|---------------------------|
| nickname          | string | null: false               |
| email             | string | null: false, unique: true |
| password          | string | null: false               |
| family_name       | string | null: false               |
| last_name         | string | null: false               |
| family_name_kana  | string | null: false               |
| last_name_kana    | string | null: false               |
| year_of_birth     | string | null: false               |
| month_of_birth    | string | null: false               |
| day_of_birth      | string | null: false               |

### Association
- has_many :items
- has_many :purchases


## items テーブル

| Column            | Type       | Options                        |
|-------------------|------------|--------------------------------|
| name              | string     | null: false                    |
| description       | text       | null: false                    |
| category          | string     | null: false                    |
| condition         | string     | null: false                    |
| delivery_fee_info | string     | null: false                    |
| ship_from         | string     | null: false                    |
| shipping_time     | string     | null: false                    |
| price             | string     | null: false                    |
| user              | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column     | Type       | Options                        |
|------------|------------|--------------------------------|
| item       | reference  | null: false, foreign_key: true |
| user       | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column         | Type   | Options     |
|----------------|--------|-------------|
| postal_code    | string | null: false |
| prefecture     | string | null: false |
| municipalities | string | null: false |
| block_number   | string | null: false |
| building       | string | null: false |
| phone_number   | string | null: false |

### Association
- belongs_to :purchase
