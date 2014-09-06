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

  def parameters
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
    }
  end

  def concataned_parameters
    parameters.
    reject { |key, value| value.nil? }.
    sort.
    map { |key, value| "#{key}=#{value}" }.
    join('&')
  end

  def hashkey(string=concataned_parameters)
    string += "&#{api_key}"
    Digest::SHA1.hexdigest string
  end

  def valid?
    response.headers['X-Sponsorpay-Response-Signature'] == hashkey(response.body)
  end

  def get
    @response = self.class.get('/', parameters)
    raise StandardError('hashkey unmatch') unless valid?
    @response
  end

  private
    def appid
      Rails.application.secrets.fyber['appid']
    end

    def ip
      Rails.application.secrets.fyber['ip']
    end

    def locale
      Rails.application.secrets.fyber['locale']
    end

    def device_id
      Rails.application.secrets.fyber['device_id']
    end

    def api_key
      Rails.application.secrets.fyber['api_key']
    end

    def response
      @response
    end
end
