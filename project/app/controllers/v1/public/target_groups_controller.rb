# frozen_string_literal: true

module V1
  module Public
    class TargetGroupsController < ApplicationController
      include SetCountry

      def country_provider_groups
        render json: TargetGroup.for_panel_provider(country.panel_provider_id)
      end
    end
  end
end
