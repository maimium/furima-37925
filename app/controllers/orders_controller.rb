class OrdersController < ApplicationController
  before_action :product_set, only: [:index, :create, :non_purchased_item]
  before_action :authenticate_user!
  before_action :non_purchased_item, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
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

  def product_set
    @product = Product.find(params[:product_id])
  end

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :house_number, :building, :phone_number).merge(user_id: current_user.id, product_id: @product.id, token: params[:token], authenticity_token: params[:authenticity_token])
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
    redirect_to root_path if current_user.id == @product.user_id || @product.order.present?
  end

end
