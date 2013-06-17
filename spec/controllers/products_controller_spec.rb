require 'spec_helper'

describe ProductsController do
  subject { create(:product) }

  describe 'GET index' do
    it 'should response successfully' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET price' do
    it 'should response successfully' do
      xhr :get, :price, id: subject.id
      expect(response).to be_success
    end

    it 'should return correct data' do
      xhr :get, :price, id: subject.id
      expect(response.body).to eq({ price: subject.price,
                                    nextSaleOffTime: subject.next_sale_off_time }.to_json)
    end
  end
end
