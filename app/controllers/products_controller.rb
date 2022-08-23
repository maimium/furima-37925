class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :show]
  before_action :product_page, only: [:show, :edit, :update]

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
  end

  def edit
    unless @product.user == current_user
      redirect_to root_path
    end
  end

  def update
    if @product.update(product_params)
      redirect_to product_path
    else
      render action: :edit
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to root_path

  end

  private

  def move_to_index
    redirect_to index unless user_signed_in?
  end

  def product_page
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_name, :image, :description, :price, :category_id, :condition_id,
                                    :delivery_charge_id, :prefecture_id, :delivery_days_id).merge(user_id: current_user.id)
  end
end
