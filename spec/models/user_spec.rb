require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'is valid when all attributes are present' do
      @user = User.new(
        first_name: 'test', 
        last_name: 'testing', 
        email: 'test@test.com', 
        password: 'test', 
        password_confirmation: 'test'
      )
      expect(@user).to be_valid
    end

    it 'is not valid when password and password_confirmation do not match' do
      @user = User.new(
        first_name: 'test', 
        last_name: 'testing', 
        email: 'test@test.com', 
        password: 'test', 
        password_confirmation: 'test2'
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is not valid without a password' do
      @user = User.new(
        first_name: 'test', 
        last_name: 'testing', 
        email: 'test@test.com', 
        password: nil, 
        password_confirmation: 'test'
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is not valid without a password confirmation' do
      @user = User.new(
        first_name: 'test', 
        last_name: 'testing', 
        email: 'test@test.com', 
        password: 'test', 
        password_confirmation: nil
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'is not valid without an email' do
      @user = User.new(
        first_name: 'test', 
        last_name: 'testing', 
        email: nil, 
        password: 'test', 
        password_confirmation: 'test'
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is not valid without a first name' do
      @user = User.new(
        first_name: nil, 
        last_name: 'testing', 
        email: 'test@test.com', 
        password: 'test', 
        password_confirmation: 'test'
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'is not valid without a last name' do
      @user = User.new(
        first_name: 'test', 
        last_name: nil, 
        email: 'test@test.com', 
        password: 'test', 
        password_confirmation: 'test'
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'is not valid if email already exists in database' do
      @user = User.create(
        first_name: 'test', 
        last_name: 'testing', 
        email: 'test@test.COM', 
        password: 'test', 
        password_confirmation: 'test'
      )
      @user2 = User.new(
        first_name: 'test', 
        last_name: 'testing', 
        email: 'TEST@TEST.com', 
        password: 'test', 
        password_confirmation: 'test'
      )
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end  

    it 'is not valid if password is too short' do
      @user = User.new(
        first_name: 'test', 
        last_name: 'testing', 
        email: 'TEST@TEST.com', 
        password: 'tes', 
        password_confirmation: 'tes'
      )
      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    
    before :each do
      @user = User.create(
        first_name: 'test', 
        last_name: 'testing', 
        email: 'test@test.com', 
        password: 'test', 
        password_confirmation: 'test'
      )
    end

    it 'should return truthy if valid credentials entered' do
      expect(User.authenticate_with_credentials(@user.email,@user.password)).to be_truthy
    end

    it 'should return falsey if invalid email entered' do
      expect(User.authenticate_with_credentials('test@test.other',@user.password)).to be_falsey
    end
    
    it 'should return falsey if invalid password' do
      expect(User.authenticate_with_credentials(@user.email,'other')).to be_falsey
    end

    it 'should return truthy if email case is different' do
      expect(User.authenticate_with_credentials('TEST@TEST.com',@user.password)).to be_truthy
    end

    it 'should return truthy if email has spaces before or after email' do
      expect(User.authenticate_with_credentials(" #{@user.email} ",@user.password)).to be_truthy
    end

  end

end
