class OrderAddress

  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :house_number, :building, :phone_number, :user_id, :product_id
  attr_accessor :token, :authenticity_token

  validates :post_code,          presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/ }
  validates :prefecture_id,      presence: true, numericality: { other_than: 1, message: "isn't selected" }
  validates :city,               presence: true
  validates :house_number,       presence: true
  validates :phone_number,       presence: true, format: { with:	/\A\d{10,11}\z/ }
  validates :user_id,            presence: true
  validates :token,              presence: true

  def save
    order = Order.create(product_id: product_id, user_id: user_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, house_number: house_number,
                   building: building, phone_number: phone_number, order_id: order.id)
  end


end