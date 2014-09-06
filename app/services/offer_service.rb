class OfferService
  include HTTParty
  base_uri 'http://api.sponsorpay.com/feed/v1/offers.json'
  format :json
end
