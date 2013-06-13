require 'spec_helper'

describe User do
  subject { create(:user) }
  let(:product) { create(:product) }

  it { should have_many(:products_followers) }
  it { should have_many(:followed_products) }
  it { should have_many(:products_consumers) }
  it { should have_many(:bought_products) }

  describe '#follow' do
    it 'should create a new relationship' do
      expect{
        subject.follow(product)
      }.to change(ProductsFollower, :count).by(1)

    end
  end

  describe '#buy' do
    before do
      product.update_attribute(:aasm_state, 'confirming')
    end

    it "should change product's state to sold" do
      subject.buy(product)
      product.sold?.should be_true
    end

    it 'should be the consumer of the product' do
      expect {
        subject.buy(product)
      }.to change(ProductsConsumer, :count).by(1)
    end
  end

  describe '#order' do
    before do
      product.update_attribute(:aasm_state, 'public')
    end

    it "should change product's state to confirming" do
      subject.order(product)
      product.confirming?.should be_true
    end

    it 'should be in the order list of the product' do
      expect {
        subject.order(product)
      }.to change(ProductsOrder, :count).by(1)
    end

  end
end
