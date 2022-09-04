class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :non_purchased_item, only: [:index, :create]

  def index
    @product = Product.find(params[:product_id])
    @order_address = OrderAddress.new
  end

  def new
    @order_address = OrderAddress.new
  end

  def create
    @product = Product.find(params[:product_id])
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:user_id, :post_code, :prefecture_id, :city, :house_number, :building, :phone_number).merge(user_id: current_user.id, product_id: @product.id, token: params[:token], authenticity_token: params[:authenticity_token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @product.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def non_purchased_item
    @product = Product.find(params[:product_id])
    redirect_to root_path if current_user.id == @product.user_id || @product.order.present?
  end

end
