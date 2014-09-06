require 'rails_helper'

describe OfferService do
  describe 'config' do
    subject { OfferService }
    its(:base_uri) { is_expected.to eql 'http://api.sponsorpay.com/feed/v1/offers.json' }
    its(:format)   { is_expected.to eql :json }
  end

  describe 'initialization' do
    it { expect{ OfferService.new(uid: 'player1') }.not_to raise_error }
    it { expect{ OfferService.new(uid: 'player1', pub0: 'campaign2', page: 1) }.not_to raise_error }
  end
end
