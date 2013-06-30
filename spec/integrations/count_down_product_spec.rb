require 'spec_helper'

describe 'count down product price', js: true do
  let(:product) { create(:product, public_time: 1.day.ago + 5.seconds) }

  it "should display product's information" do
    visit product_path(product)
    pending
  end
end
