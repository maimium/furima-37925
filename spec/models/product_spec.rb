require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
    @user = FactoryBot.build(:user)
  end

  describe '商品出品機能' do
    context '出品できる場合' do
      it 'すべての項目が入力されていると出品できること' do
        @product.valid?
        expect(@product).to be_valid
      end
    end

    context '出品できない場合' do
      it '商品画像が1枚もついていないと出品できないこと' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空だと出品できないこと' do
        @product.product_name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Product name can't be blank")
      end
      it '商品の説明が空だと出品できないこと' do
        @product.description = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーの情報が空だと出品できないこと' do
        @product.category_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態の情報が空だと出品できないこと' do
        @product.condition_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Condition can't be blank")
      end
      it '配送料の負担の情報が空だと出品できないこと' do
        @product.delivery_charge_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Delivery charge can't be blank")
      end
      it '発送元の地域の情報が空だと出品できないこと' do
        @product.prefecture_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数の情報が空だと出品できないこと' do
        @product.delivery_days_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Delivery days can't be blank")
      end
      it '価格の情報が空だと出品できないこと' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が¥300未満だと出品できないこと' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it '価格が¥9,999,999より大きいと出品できないこと' do
        @product.price = 10_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it '価格が半角数値以外だと出品できないこと' do
        @product.price = '３００'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price is not a number')
      end
      it '価格にコンマが入ると出品できないこと' do
        @product.price = '1,000'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price is not a number')
      end
      it 'ユーザー情報が紐付いていなければ出品できないこと' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("User must exist")
      end
    end
  end
end
