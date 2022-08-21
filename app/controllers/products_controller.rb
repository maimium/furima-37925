class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :move_to_index, except: [:index, :show]

  def index
    @products = Product.all.order(created_at: :desc)
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

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
    unless @product.user == current_user
      redirect_to root_path
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path
    else
      render action: :edit
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
