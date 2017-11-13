require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save successfully if all fields are valid' do
      @category = Category.create(name: 'Something')
      @product = @category.products.create(name: 'Chair', price: 10, quantity: 2)
      expect(Product.count).to eq 1
    end

    it 'should raise validation error without a name' do
      @category = Category.create(name: 'Something')
      @product = @category.products.create(name: nil, price: 10, quantity: 2)
      expect(Product.count).to eq 0
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should raise validation error without a price' do
      @category = Category.create(name: 'Something')
      @product = @category.products.create(name: 'Chair', price: nil, quantity: 2)
      expect(Product.count).to eq 0
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should raise validation error without a quantity' do
      @category = Category.create(name: 'Something')
      @product = @category.products.create(name: 'Chair', price: 10, quantity: nil)
      expect(Product.count).to eq 0
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should raise validation error without a category' do
      @product = Product.create(name: 'Chair', price: 10, quantity: 2)
      expect(Product.count).to eq 0
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
