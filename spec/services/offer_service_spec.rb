require 'rails_helper'

describe OfferService do
  describe 'config' do
    it { expect(OfferService.base_uri).to eql 'http://api.sponsorpay.com/feed/v1/offers.json' }
    it { expect(OfferService.format).to eql :json }
  end
end
