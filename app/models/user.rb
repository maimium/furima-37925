class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :password,                            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, allow_blank: true }
  validates :family_name,        presence: true,  format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, allow_blank: true }
  validates :personal_name,      presence: true,  format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, allow_blank: true }
  validates :family_name_kana,   presence: true,  format: { with: /\A[ァ-ヶー－]+\z/, allow_blank: true }
  validates :personal_name_kana, presence: true,  format: { with: /\A[ァ-ヶー－]+\z/, allow_blank: true }
  validates :birthday,           presence: true
end
