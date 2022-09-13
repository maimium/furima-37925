require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @product = FactoryBot.create(:product)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, product_id: @product.id)
    sleep(0.1)
  end

  describe '購入機能' do
    context '購入できる場合' do
      it 'すべての項目が入力されていると購入できること' do
        expect(@order_address).to be_valid
      end
      it '建物名が空でも購入できること' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '購入できない場合' do
      it '郵便番号が空だと購入できないこと' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages)
        .to include("郵便番号を入力してください")
      end
      it '郵便番号にハイフンが含まれていないと購入できないこと' do
        @order_address.post_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages)
        .to include("郵便番号は不正な値です")
      end
      it '郵便番号が7桁未満だと購入できないこと' do
        @order_address.post_code = '123-456'
        @order_address.valid?
        expect(@order_address.errors.full_messages)
        .to include("郵便番号は不正な値です")
      end
      it '郵便番号が8桁以上だと購入できないこと' do
        @order_address.post_code = '1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages)
        .to include("郵便番号は不正な値です")
      end
      it '都道府県が空だと購入できないこと' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages)
        .to include("都道府県を選択してください")
      end
      it '市区町村が空だと購入できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages)
        .to include("市区町村を入力してください")
      end
      it '番地が空だと購入できないこと' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages)
        .to include("番地を入力してください")
      end
      it '電話番号が空だと購入できないこと' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages)
        .to include("電話番号を入力してください")
      end
      it '電話番号にハイフンが含まれていると購入できないこと' do
        @order_address.phone_number = '123-456-789'
        @order_address.valid?
        expect(@order_address.errors.full_messages)
        .to include("電話番号は不正な値です")
      end
      it '電話番号が12桁以上の半角数値だと購入できないこと' do
        @order_address.phone_number = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages)
        .to include("電話番号は不正な値です")
      end
      it '電話番号が9桁以下の半角数値だと購入できないこと' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages)
        .to include("電話番号は不正な値です")
      end
      it "tokenが空では登録できないこと" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages)
        .to include("カード情報を全て入力してください")
      end
      it 'user_idが空では購入できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages)
        .to include("ユーザー情報が紐づいていません")
      end
      it 'product_idが空では購入できないこと' do
        @order_address.product_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages)
        .to include("商品情報が紐づいていません")
      end
    end
  end

end