# frozen_string_literal: true

module V1
  module Private
    class LocationsController < PrivateBaseController
      include SetCountry

      def country_locations
        render json: country.current_provider_locations
      end
    end
  end
end
