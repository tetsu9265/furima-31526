class OrderAddress
  include ActiveModel::Model
  attr_accessor :user, :item, :postal_code, :prefecture_id, :municipalities, :block_number, :building, :phone_number, :token
  with_options presence: true do
    validates :user
    validates :item
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipalities
    validates :block_number
    validates :phone_number, numericality: { only_integer: true }, length: { in: 10..11 }
  end

  def save
    order = Order.create(user_id: user.id, item_id: item.id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, block_number: block_number, building: building, phone_number: phone_number, order_id: order.id)
  end
end