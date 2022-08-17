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
  validates :price,              presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300,
                                                                 less_than_or_equal_to: 9_999_999 }
  validates :category_id,        presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id,       presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_charge_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id,      presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_days_id,   presence: true, numericality: { other_than: 1, message: "can't be blank" }
end
