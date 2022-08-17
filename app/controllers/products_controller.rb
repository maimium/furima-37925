class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :move_to_index, except: :index

  def index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  private

  def move_to_index
    redirect_to index unless user_signed_in?
  end

  def product_params
    params.require(:product).permit(:product_name, :image, :description, :price, :category_id, :condition_id,
                                    :delivery_charge_id, :prefecture_id, :delivery_days_id).merge(user_id: current_user.id)
  end
end
