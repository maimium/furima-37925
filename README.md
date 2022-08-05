# README

# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
|--------------------|--------|---------------------------|
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| family_name        | string | null: false               |
| personal_name      | string | null: false               |
| family_name_kana   | string | null: false               |
| personal_name_kana | string | null: false               |
| birthday           | data   | null: false               |

### Association

- has_many :product
- has_many :order
- has_many :address

## products テーブル

| Column          | Type       | Options                        |
|-----------------|------------|--------------------------------|
| user            | references | null: false, foreign_key: true |
| product_name    | string     | null: false                    |
| description     | string     | null: false                    |
| price           | string     | null: false                    |
| image           | string     | null: false                    |
| category        | integer    | null: false                    |
| condition       | integer    | null: false                    |
| delivery_charge | integer    | null: false                    |
| prefecture      | integer    | null: false                    |
| delivery_days   | integer    | null: false                    |


### Association

- belongs_to :user
- has_one :order
- belongs_to_active_hash :category
- belongs_to_active_hash :condition
- belongs_to_active_hash :delivery_charge
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :delivery_days

## orders テーブル

| Column   | Type       | Options                        |
|----------|------------|--------------------------------|
| user     | references | null: false, foreign_key: true |
| product  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product
- has_one :address

## addresses テーブル

| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| user         | references | null: false, foreign_key: true |
| post_code    | string     | null: false                    |
| prefecture   | integer    | null: false                    |
| city         | string     | null: false                    |
| house_number | string     | null: false                    |
| building     | string     |                                |
| phone_number | string     | null: false                    |

### Association

- belongs_to :user
- has_one :order
- has_one_active_hash :prefecture
