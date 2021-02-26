class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :shipping_time

  with_options presence: true do
    validates :name
    validates :description
    validates :image
  end
  with_options presence: true, numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :shipping_time_id
  end
  validates :price, presence: true, numericality: { only_integer: true,  greater_than: 299, less_than: 10000000 }
end
