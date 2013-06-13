require 'spec_helper'

describe Product do
  subject { create(:product) }

  it 'should be private' do
    subject.private?.should be_true
  end
end
