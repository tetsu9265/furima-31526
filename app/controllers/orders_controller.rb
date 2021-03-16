class OrdersController < ApplicationController
  def index
    @order_address = OrderAddress.new
    @order_address.user = User.find(current_user.id)
    @order_address.item = Item.find(params[:item_id])
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    @order_address.user = User.find(current_user.id)
    @order_address.item = Item.find(params[:item_id])
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to item_path(@order_address.item.id)
    else
      render action: :index
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :municipalities, :block_number, :building, :phone_number).merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: Item.find(params[:item_id]).price,
      card: order_address_params[:token],
      currency: 'jpy'
    )
  end
end
