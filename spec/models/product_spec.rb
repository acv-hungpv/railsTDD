require 'rails_helper'
# RSpec.describe Product, type: :model do
#   it 'validates the presence of title' do
#     product = Product.new(title: '')
#     product.validate
#     expect(product.errors.messages).to include(title: ["can't be blank"])
#   end
# end

# RSpec.describe Product, type: :model do
#   it 'validates the presence of description' do 
#     product = Product.new(description: '')
#     product.validate
#     expect(product.errors.messages) .to include(description: ["can't be blank"])
#   end
# end
RSpec.describe Product, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price).is_greater_than(0) }
  context "Association" do
    it {should belong_to(:category)}
  end

  it 'validate title is shorter than description' do
    category = Category.create!(title:"test title is shorter than description in product")
    product = category.products.build(title:"test", description: "test1",price:10)
    expect(product.title.length).to be <= product.description.length
  end

  context "Custom validate" do
    it "expect strip HTML from description field" do
      category = Category.create!(title:"test strip HTML")
      product = category.products.build(title:"test", description:"<h1>test strip HTML from description</h1>",price: 10)
      expect { product.descripiton.to eq "test strip HTML from description" }
    end
    it "expect set title to lower case" do 
      category = Category.create!(title: "test lower case for product title")
      product = category.products.build(title:"test LOWER CASE", description:"<h1>test strip HTML from description</h1>",price: 10)
      expect { product.title.to eq "test lower case" }
    end
  end
end 

RSpec.describe Category, type: :model do
  it { should have_many(:products)}
end