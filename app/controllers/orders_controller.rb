class OrdersController < ApplicationController
  def index
    @order_address = OrderAddress.new.merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
