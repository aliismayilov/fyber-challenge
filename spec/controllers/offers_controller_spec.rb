require 'rails_helper'

RSpec.describe OffersController, :type => :controller do

  describe "GET index" do
    before do
      allow_any_instance_of(OfferService).to receive(:get) do
        double('response', body: {
         "code"  => " OK" ,
         "message" => "OK",
         "count" => "1" ,
         "pages" => "1" ,
         "information"  => {
          "app_name" => "SP Test App" ,
          "appid" => "157",
          " virtual_ currency" => "Coins",
          "country" => " US" ,
          "language" => " EN" ,
          "support_url"  => "http://iframe.sponsorpay.com/mobile/DE/157/my_offers"
         },
         "offers"  => [
          {
            "title" => " Tap  Fish",
            "offer_id" => " 13554",
            " teaser "  => "  Download and START " ,
            " required _actions "  => "Download and START",
            "link"  => "http://iframe.sponsorpay.com/mbrowser?appid=157&lpid=11387&uid=player1",
            "offer_types"  => [
             {
              "offer_type_id" => "101",
              "readable" => "Download"
             },
             {
              "offer_type_id" => "112",
              "readable" => "Free"
             }
            ] ,
            "thumbnail"  => {
             "lowres"  => "http://cdn.sponsorpay.com/assets/1808/icon175x175- 2_square_60.png" ,
             "hires" => "http://cdn.sponsorpay.com/assets/1808/icon175x175- 2_square_175.png"
            },
            "payout"  => "90",
            "time_to_payout"  => {
             "amount"  => "1800" ,
             "readable" => "30 minutes"
            }
          }
         ]
        }.to_json)
      end
    end

    it 'calls OfferService and responds with success' do
      expect_any_instance_of(OfferService).to receive(:get)
      get :index, uid: 'player1'
      is_expected.to respond_with :success
    end
  end

end
