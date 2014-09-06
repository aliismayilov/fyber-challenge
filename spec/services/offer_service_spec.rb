require 'rails_helper'

describe OfferService do
  describe 'config' do
    subject { OfferService }
    its(:base_uri) { is_expected.to eql 'http://api.sponsorpay.com/feed/v1/offers.json' }
    its(:format)   { is_expected.to eql :json }
  end
end
