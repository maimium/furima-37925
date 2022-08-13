class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,           presence: true
  validates :password,                            format: { with:/\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i }#, message: "は半角英数混合で入力してください"}
  validates :family_name,        presence: true,  format: { with:/\A[ぁ-んァ-ン一-龥々ー]+\z/ }#, message: "は全角ひらがな/カタカナまたは漢字で入力してください"}
  validates :personal_name,      presence: true,  format: { with:/\A[ぁ-んァ-ン一-龥々ー]+\z/ }#, message: "は全角ひらがな/カタカナまたは漢字で入力してください"}
  validates :family_name_kana,   presence: true,  format: { with:/\A[ァ-ヶー－]+\z/ }#, message: "は全角カタカナで入力してください"}
  validates :personal_name_kana, presence: true,  format: { with:/\A[ァ-ヶー－]+\z/ }#, message: "は全角カタカナで入力してください"}
  validates :birthday,           presence: true
end
