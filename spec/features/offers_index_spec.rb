require 'rails_helper'

describe 'Offers index page' do
  context 'there are offers' do
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

    it 'queries offers' do
      visit offers_path
      fill_in 'uid', with: 'player1'
      fill_in 'pub0', with: 'campaign2'
      fill_in 'page', with: 1
      click_button 'Show offers'
      expect(page).to have_css('.offer', count: 1)
      expect(page).to have_content 'Tap  Fish'
    end
  end

  context 'no offers' do
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
         "offers"  => []
        }.to_json)
      end
    end

    it 'queries offers' do
      visit offers_path
      fill_in 'uid', with: 'player1'
      fill_in 'pub0', with: 'campaign2'
      fill_in 'page', with: 1
      click_button 'Show offers'
      expect(page).to have_css '.no_offers'
      expect(page).to have_content 'No offers'
    end
  end
end
