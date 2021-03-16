class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_top_page

  def index
    @order_address = OrderAddress.new
    set_user
    set_item
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    set_user
    set_item
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :municipalities, :block_number, :building,
                                          :phone_number).merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: Item.find(params[:item_id]).price,
      card: order_address_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_top_page
    item = Item.find(params[:item_id])
    seller_id = item.user.id
    if current_user.id == seller_id || Order.find_by(item_id: item.id).present?
      redirect_to root_path
    end
  end

  def set_user
    @order_address.user = User.find(current_user.id)
  end

  def set_item
    @order_address.item = Item.find(params[:item_id])
  end
end
