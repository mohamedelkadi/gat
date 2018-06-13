# frozen_string_literal: true

class Country < ApplicationRecord
  belongs_to :panel_provider
  has_many :location_groups
  has_and_belongs_to_many :target_groups

  validates :code, presence: true, uniqueness: true
  validates :panel_provider, presence: true

  def current_provider_locations
    Location.includes(:location_groups).where(location_groups: {
                                                country_id: id,
                                                panel_provider_id: panel_provider_id
                                              })
  end
end
