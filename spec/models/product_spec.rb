require 'rails_helper'
RSpec.describe Product, type: :model do
  it 'validates the presence of title' do
    product = Product.new(title: '')
    product.validate
    expect(product.errors.messages).to include(title: ["can't be blank"])
  end
end

RSpec.describe Product, type: :model do
  it 'validates the presence of description' do 
    product = Product.new(description: '')
    product.validate
    expect(product.errors.messages) .to include(description: ["can't be blank"])
  end
end