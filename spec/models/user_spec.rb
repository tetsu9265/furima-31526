require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "新規登録できるとき" do
      it "nickname,email,password,password_confirmation,family_name,given_name,family_name_kana,given_name_kana,birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "nicknameが40文字以下なら登録できる" do
        @user.nickname = "asdfgasdfgasdfgasdfgasdfgasdfgasdfgasdfg"
        expect(@user).to be_valid
      end
      it "passwordとpassword_confirmationが半角英数字混合六文字以上なら登録できる" do
        @user.password = "aaa111"
        @user.password_confirmation = "aaa111"
        expect(@user).to be_valid
      end
      it "family_nameが全角文字なら登録できる" do
        @user.family_name = "山田"
        expect(@user).to be_valid
      end
      it "given_nameが全角文字なら登録できる" do
        @user.given_name = "陸太郎"
        expect(@user).to be_valid
      end
      it "family_name_kanaが全角カタカナなら登録できる" do
        @user.family_name_kana = "ヤマダ"
        expect(@user).to be_valid
      end
      it "given_name_kanaが全角カタカナなら登録できる" do
        @user.given_name_kana = "リクタロウ"
        expect(@user).to be_valid
      end
    end
    context "新規登録できないとき" do
      it "nicknameが空だと登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空だと登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordが空だと登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが存在してもpassword_confirmationが空だと登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "family_nameが空だと登録できない" do
        @user.family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it "given_nameが空だと登録できない" do
        @user.given_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name can't be blank")
      end
      it "family_name_kanaが空だと登録できない" do
        @user.family_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it "given_name_kanaが空だと登録できない" do
        @user.given_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name kana can't be blank")
      end
      it "birthdayが空だと登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it "nicknameが41文字以上では登録できない" do
        @user.nickname = "12345123451234512345123451234512345123451"
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is too long (maximum is 40 characters)")
      end
      it "emailが重複しているなら登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "passwordが5文字以下では登録できない" do
        @user.password = "aaa11"
        @user.password_confirmation = "aaa11"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが英字のみでは登録できない" do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      it "passwordが数字のみでは登録できない" do
        @user.password = "111111"
        @user.password_confirmation = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      it "family_nameが全角文字でなければ登録できない" do
        @user.family_name = "aaa111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name 全角文字を使用してください")
      end
      it "given_nameが全角文字でなければ登録できない" do
        @user.given_name = "aaa111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name 全角文字を使用してください")
      end
      it "family_name_kanaが全角カタカナでなければ登録できない" do
        @user.family_name_kana = "aa11あ阿"
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name kana 全角（カタカナ）を使用してください")
      end
      it "given_name_kanaが全角カタカナでなければ登録できない" do
        @user.given_name_kana = "aa11あ阿"
        @user.valid?
        expect(@user.errors.full_messages).to include("Given name kana 全角（カタカナ）を使用してください")
      end
    end
  end
end
