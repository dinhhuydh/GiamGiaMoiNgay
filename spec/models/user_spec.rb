require 'spec_helper'

describe User do
  let(:user) { create(:user) }
  let(:product) { create(:product) }

  it { should have_many(:products_followers) }
  it { should have_many(:followed_products) }
  it { should have_many(:products_consumers) }
  it { should have_many(:bought_products) }

  describe '#follow' do
    it 'should create a new relationship' do
      expect{
        user.follow(product)
      }.to change(ProductsFollower, :count).by(1)

    end
  end
end
