require 'spec_helper'

describe 'show product' do
  let(:product) { create(:product) }

  it "should display product's information" do
    visit product_path(product)

    expect(page).to have_content(product.name)
    expect(page).to have_content(product.price)
    expect(page).to have_content(product.description)
  end
end
