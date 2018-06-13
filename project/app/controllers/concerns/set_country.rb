# frozen_string_literal: true

module SetCountry
  extend ActiveSupport::Concern
  included do
    before_action :set_country
    attr_reader :country
  end

  def set_country
    code = params.fetch(:code).upcase
    @country = Country.find_by!(code: code)
  end
end
