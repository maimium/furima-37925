require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録' do
    context '登録できる場合' do
      it 'すべての項目を入力すれば登録できること' do
        expect(@user).to be_valid
      end
      it 'パスワードとパスワード(確認)が6文字以上で、かつ一致していれば登録できること' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end
      it 'お名前(全角)が全角であれば登録できること' do
        @user.family_name = '佐藤'
        @user.personal_name = 'としお'
        expect(@user).to be_valid
      end
      it 'お名前カナ(全角)が全角であれば登録できること' do
        @user.family_name_kana = 'サトウ'
        @user.personal_name_kana = 'トシオ'
        expect(@user).to be_valid
      end
    end

    context '登録できない場合' do
      it 'ニックネームが空では登録できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したメールアドレスが存在する場合は登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'メールアドレスは、＠を含まないと登録できないこと' do
        @user.email = 'testcom'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'パスワードが空では登録できないこと' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが5文字以下だと登録できないこと' do
        @user.password = '123ab'
        @user.password_confirmation = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'パスワードが数字のみだと登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードが英字のみだと登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードが半角英数字以外だと登録できないこと' do
        @user.password = 'いろはにほへと'
        @user.password_confirmation = 'いろはにほへと'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードとパスワード(確認)が異なる場合は登録できないこと' do
        @user.password = '00000a'
        @user.password_confirmation = '00000b'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'お名前(全角)は、名字が空では登録できないこと' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it 'お名前(全角)は、名前が空では登録できないこと' do
        @user.personal_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Personal name can't be blank")
      end
      it 'お名前(全角)は、名字が半角では登録できないこと' do
        @user.family_name = 'ｻﾄｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end
      it 'お名前(全角)は、名前が半角では登録できないこと' do
        @user.personal_name = 'ﾄｼｵ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Personal name is invalid")
      end
      it 'お名前(全角)は、名字が英数字では登録できないこと' do
        @user.family_name = 'SAT0'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end
      it 'お名前(全角)は、名前が英数字では登録できないこと' do
        @user.personal_name = 'TOSHI0'
        @user.valid?
        expect(@user.errors.full_messages).to include("Personal name is invalid")
      end
      it 'お名前カナ(全角)は、名字が空では登録できないこと' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it 'お名前カナ(全角)は、名前が空では登録できないこと' do
        @user.personal_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Personal name kana can't be blank")
      end
      it 'お名前カナ(全角)は、名字が半角では登録できないこと' do
        @user.family_name_kana = 'ｻﾄｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana is invalid")
      end
      it 'お名前カナ(全角)は、名前が半角では登録できないこと' do
        @user.personal_name_kana = 'ﾄｼｵ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Personal name kana is invalid")
      end
      it '生年月日が空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end

