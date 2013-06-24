require 'spec_helper'

describe Product do
  subject { create(:product) }

  it 'should be private' do
    subject.private?.should be_true
  end

  describe 'aasm' do
    context 'when the state is to sold' do
      before do
        subject.update_attribute(:aasm_state, 'confirming')
      end

      it 'should send notification' do
        delay_mock = mock()
        Product.any_instance.stub(:delay).and_return(delay_mock)
        delay_mock.should_receive(:already_sold_notification)
        subject.be_sold!
      end
    end
  end
end
