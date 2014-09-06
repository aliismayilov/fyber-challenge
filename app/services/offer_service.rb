class OfferService
  include HTTParty
  base_uri 'http://api.sponsorpay.com/feed/v1/offers.json'
  format :json

  def initialize(uid, pub0: nil, page: nil, ps_time: nil)
    @uid      = uid
    @pub0     = pub0
    @page     = page
    @ps_time  = ps_time
  end

  def hashvalues
    {
      appid: appid,
      uid: @uid,
      ip: ip,
      locale: locale,
      device_id: device_id,
      ps_time: @ps_time,
      pub0: @pub0,
      page: @page,
      timestamp: Time.now.to_i
    }.reject { |key, value| value.nil? }
  end

  def hashkey
    string = hashvalues.sort.map { |key, value| "#{key}=#{value}" }.join('&')
    string += "&#{api_key}"
    Digest::SHA1.hexdigest string
  end
end
