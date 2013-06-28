require 'spec_helper'

describe Product do
  subject { create(:product) }

  it 'should be private' do
    subject.private?.should be_true
  end

  describe 'aasm' do
    context 'when the state is to public' do
      before do
        subject.update_attribute(:aasm_state, 'private')
      end

      it 'should send public state notification' do
        delay_mock = mock()
        Product.any_instance.stub(:delay).and_return(delay_mock)
        delay_mock.should_receive(:public_state_notification)
        subject.be_public!
      end
    end

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

  describe '#public_state_notification' do
    let!(:user_1) { create(:user) }
    let!(:user_2) { create(:user) }
    let!(:user_3) { create(:user) }

    before do
      user_2.setting.update_attribute(:public_product_notification, true)
      user_3.setting.update_attribute(:public_product_notification, true)
    end

    it 'should notify to users enjoy' do
      email_mock = mock()
      email_mock.stub(:deliver)
      ProductMailer.should_receive(:public_state).exactly(2).times.and_return(email_mock)
      subject.send(:public_state_notification)
    end
  end
end
