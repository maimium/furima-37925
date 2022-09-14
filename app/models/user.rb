class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
  validates :nickname
  validates :password,           format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, allow_blank: true }
  validates :family_name,        format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, allow_blank: true }
  validates :personal_name,      format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, allow_blank: true }
  validates :family_name_kana,   format: { with: /\A[ァ-ヶー－]+\z/, allow_blank: true }
  validates :personal_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, allow_blank: true }
  validates :birthday
  end

  has_many :comments

end
