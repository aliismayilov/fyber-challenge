require 'rails_helper'

RSpec.describe OffersController, :type => :controller do

  describe "GET index" do
    it 'calls OfferService and responds with success' do
      expect_any_instance_of(OfferService).to receive(:get)
      get :index
      is_expected.to respond_with :success
    end
  end

end
