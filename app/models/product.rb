class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one :order
  has_one_attached :image

  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_days

  validates :image,              presence: true
  validates :product_name,       presence: true, length: { maximum: 40 }
  validates :description,        presence: true, length: { maximum: 1000 }
  validates :price,              presence: true, numericality: { only_integer: true, message: "は半角数字のみで入力してください" }
  validates :price,              presence: true, numericality: {greater_than_or_equal_to: 300, message: "は300円以上にしてください"}
  validates :price,              presence: true, numericality: {less_than_or_equal_to: 9_999_999, message: "は9,999,999円以下にしてください", allow_blank: true }
  validates :category_id,        presence: true, numericality: { other_than: 1, message: "を選択してください", allow_blank: true }
  validates :condition_id,       presence: true, numericality: { other_than: 1, message: "を選択してください", allow_blank: true }
  validates :delivery_charge_id, presence: true, numericality: { other_than: 1, message: "を選択してください", allow_blank: true }
  validates :prefecture_id,      presence: true, numericality: { other_than: 1, message: "を選択してください", allow_blank: true }
  validates :delivery_days_id,   presence: true, numericality: { other_than: 1, message: "を選択してください", allow_blank: true }
end
