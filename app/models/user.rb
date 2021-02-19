class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true, length: { maximum: 40 }
  PASSWORD_REGIX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGIX, message: 'には英字と数字の両方を含めて設定してください'
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: '全角文字を使用してください' } do
    validates :family_name
    validates :given_name
  end
  with_options presence: true, format: { with: /\A[ァ-ヶ]+\z/, message: '全角（カタカナ）を使用してください' } do
    validates :family_name_kana
    validates :given_name_kana
  end
  validates :birthday, presence: true
end
