class OffersController < ApplicationController
  def index
    if params[:uid]
      offer_service = OfferService.new params[:uid], pub0: params[:pub0], page: params[:page]
      service_response = offer_service.get
      @offers = JSON.parse(service_response.body)['offers']
    end
  end
end
