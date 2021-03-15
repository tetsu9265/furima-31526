class OrdersController < ApplicationController
  def index
    @order_address = OrderAddress.new
    @order_address.user = User.find(current_user.id)
    @order_address.item = Item.find(params[:item_id])
  end
end
