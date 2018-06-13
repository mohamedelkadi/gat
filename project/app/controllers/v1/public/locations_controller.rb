module V1
  module Public
    class LocationsController < ApplicationController
      include SetCountry

      def country_locations
        render json: country.current_provider_locations
      end
    end
  end
end