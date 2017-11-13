require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    before :each do
      @category = Category.create
    end

    it 'is valid when all attributes are present' do
      @product = @category.products.new(name: 'product', price: 10, quantity: 5)
      expect(@product.save).to be true
    end

    it 'is not valid without a name' do
      @product = @category.products.new(name: nil, price: 10, quantity: 5)
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without a price' do
      @product = @category.products.new(name: 'product', price: nil, quantity: 5)
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'is not valid without a quantity' do
      @product = @category.products.new(name: 'product', price: 10, quantity: nil)
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is not valid without a category' do
      @product = Product.new(name: 'product', price: 10, quantity: 5, category: nil)
      expect(@product.save).to be false
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end

end
