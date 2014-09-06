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

  describe '#hashkey' do
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

  describe '#valid?' do
    subject(:offer_service) { OfferService.new('player1') }

    let(:response_body) do
      {
       "code"  =>  " OK" ,
       "message" =>  "OK",
       "count" =>  "1" ,
       "pages" =>  "1" ,
       "information"  =>  {
        "app_name" =>  "SP Test App" ,
        "appid" =>  "157",
        " virtual_ currency" =>  "Coins",
        "country" =>  " US" ,
        "language" =>  " EN" ,
        "support_url"  =>  "http://iframe.sponsorpay.com/mobile/DE/157/my_offers"
       },
       "offers"  =>  [
        {
          "title" =>  " Tap  Fish",
          "offer_id" =>  " 13554",
          " teaser "  =>  "  Download and START " ,
          " required _actions "  =>  "Download and START",
          "link"  =>  "http://iframe.sponsorpay.com/mbrowser?appid=157&lpid=11387&uid=player1",
          "offer_types" =>  [
           {
            "offer_type_id"=>  "101",
            "readable"=>  "Download"
           },
           {
            "offer_type_id"=>  "112",
            "readable"=>  "Free"
           }
          ] ,
          "thumbnail" =>  {
           "lowres" =>  "http://cdn.sponsorpay.com/assets/1808/icon175x175- 2_square_60.png" ,
           "hires" =>  "http://cdn.sponsorpay.com/assets/1808/icon175x175- 2_square_175.png"
          },
          "payout"  =>  "90",
          "time_to_payout"  =>  {
           "amount"  =>  "1800" ,
           "readable" =>  "30 minutes"
          }
        }
       ]
      }.to_json
    end
    before do
      allow(offer_service).to receive(:response) { response }
    end

    context 'valid' do
      let(:response) { double('response', body: response_body, headers: {'X-Sponsorpay-Response-Signature' => '4590d15cdb128f124ce7c721e8153337b8371fe0'} ) }

      it { is_expected.to be_valid }
    end

    context 'invalid' do
      let(:response) { double('response', body: response_body, headers: {'X-Sponsorpay-Response-Signature' => '123'} ) }

      it { is_expected.not_to be_valid }
    end
  end

  describe '#get', :vcr do
    let(:offer_service) { OfferService.new 'player1' }

    context 'valid' do
      before { allow(offer_service).to receive(:valid?) { true } }
      it 'returns an HTTParty response' do
        expect(offer_service.get.class).to eql HTTParty::Response
      end
    end

    context 'invalid' do
      before { allow(offer_service).to receive(:valid?) { false } }
      it 'raises a StandardError' do
        expect{ offer_service.get }.to raise_error StandardError
      end
    end
  end
end
