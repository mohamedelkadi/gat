# frozen_string_literal: true

class Target
  include ActiveModel::Validations
  validate :country_existence, :target_group_existence, :locations_existence, :target_country_relation

  def initialize(country_code, target_group_id, locations)
    @country_code = country_code
    @target_group_id = target_group_id
    @locations = locations
  end

  def country_existence
    return if Country.exists?(code: @country_code)
    errors.add(:country, "No country with code #{@country_code}")
  end

  def target_group_existence
    return if TargetGroup.exists?(@target_group_id)
    errors.add(:target_group, "No country with code #{@country_code}")
  end

  def target_country_relation
    return unless Country.exists?(code: @country_code)
    return if Country.find_by_code(@country_code).target_groups.exists?(@target_group_id)

    errors.add(:target_country_relation, 'Target not available in this country')
  end

  # TODO: validate if the location linked to the company or not
  def locations_existence
    not_exists_ids = @locations.reject do |loc|
      Location.exists?(loc[:id])
    end

    return if not_exists_ids.blank?

    errors.add(:locations, "No locations with ids #{not_exists_ids}")
  end

  def eval
    panel_provider = Country.find_by_code(@country_code).panel_provider
    unit_price = Pricing.new(panel_provider).price
    # The target group id isn't used here and i think it should have a reason
    # to be in post body target groups look like categories based on functionality
    # so i think locations may have related to target group and the total size
    # will be the sum of panels that in location group and target group
    total_size = @locations.reduce(0) { |sum, val| val[:size] + sum }

    unit_price * total_size
  end
end
