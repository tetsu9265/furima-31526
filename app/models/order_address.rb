class OrderAddress
  include ActiveModel::ActiveModel
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipalities, :block_number, :building, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :municipalities
    validates :block_number
    validates :phone_number
  end
end