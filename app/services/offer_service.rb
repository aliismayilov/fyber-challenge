class OfferService
  include HTTParty
  base_uri 'http://api.sponsorpay.com/feed/v1/offers.json'
  format :json

  def initialize(uid, pub0=nil, page=nil)
    @uid  = uid
    @pub0 = pub0
    @page = page
  end
end
