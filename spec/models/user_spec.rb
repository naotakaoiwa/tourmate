require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録出来る時' do
      it '正常に登録出来る' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録出来る' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        expect(@user).to be_valid
      end
    end
    context '新規登録出来ない時' do
      it 'nickname:必須' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'nickname:漢字は登録出来ない'do
        @user.nickname = 'テスト'
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is invalid. Input English letters")
      end
      it 'email:必須' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'email:一意性' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'email:@必須' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'password:必須' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'password_confirmation:必須' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'password:6文字以上必須' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordとpassword(確認):一致必須' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'gender:必須' do
        @user.gender = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Gender can't be blank")
      end
      it 'gender:漢字は登録出来ない' do
        @user.gender = '男'
        @user.valid?
        expect(@user.errors.full_messages).to include("Gender is invalid. Input English letters")
      end
      it 'age:必須' do
        @user.age = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Age can't be blank")
      end
      it 'age:全角数字は登録出来ない' do
        @user.age = '３０'
        @user.valid?
        expect(@user.errors.full_messages).to include("Age is not a number")
      end
      it 'age:漢字は登録出来ない' do
        @user.age = '三十'
        @user.valid?
        expect(@user.errors.full_messages).to include("Age is not a number")
      end
    end
  end
end
