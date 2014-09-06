require 'rails_helper'

describe OfferService do
  describe 'config' do
    subject { OfferService }
    its(:base_uri) { is_expected.to eql 'http://api.sponsorpay.com/feed/v1/offers.json' }
    its(:format)   { is_expected.to eql :json }
  end

  describe 'initialization' do
    it { expect{ OfferService.new('player1') }.not_to raise_error }
    it { expect{ OfferService.new('player1', pub0: 'campaign2', page: 1) }.not_to raise_error }
  end

  describe 'hashkey' do
    subject(:offer_service) { OfferService.new('player1', pub0: 'campaign2', page: 2, ps_time: 1312211903) }
    before do
      allow(offer_service).to receive(:appid) { 157 }
      allow(offer_service).to receive(:ip) { '212.45.111.17' }
      allow(offer_service).to receive(:locale) { :de }
      allow(offer_service).to receive(:device_id) { '2b6f0cc904d137be2e1730235f5664094b831186' }
      allow(offer_service).to receive(:timestamp) { 1312553361 }
      allow(offer_service).to receive(:api_key) { 'e95a21621a1865bcbae3bee89c4d4f84' }
      travel_to Time.at 1312553361
    end

    its(:hashkey) { is_expected.to eql '7a2b1604c03d46eec1ecd4a686787b75dd693c4d' }
  end
end
