require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '注文情報の保存' do
    before do
      @order_address = FactoryBot.build(:order_address)
      @order_address.user = FactoryBot.build(:user)
      @order_address.item = FactoryBot.build(:item)
    end

    context '注文情報が保存できる時' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '注文情報が保存できないとき' do
      it 'postal_codeが空だと保存できないこと' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形でないと保存できないこと' do
        @order_address.postal_code = 1_234_567
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefectureを選択していないと保存できないこと' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'municipalitiesが空だと保存できないこと' do
        @order_address.municipalities = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Municipalities can't be blank")
      end
      it 'block_numberが空だと保存できないこと' do
        @order_address.block_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Block number can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが11桁以内でないと保存できないこと' do
        @order_address.phone_number = 123_456_123_456
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end
      it 'phone_numberが英数混合では登録できないこと' do
        @order_address.phone_number = 'abcdef12345'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is not a number")
      end
      it 'tokenが空では保存できないこと' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'userが空では保存できないこと' do
        @order_address.user = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが空では保存できないこと' do
        @order_address.item = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
