PANEL_PROVIDERS_CODES = %w[times_a 10_arrays times_html].freeze

COUNTRIES = [
  { code: "PL", panel_provider_code: "times_a" },
  { code: "US", panel_provider_code: "10_arrays" },
  { code: "UK", panel_provider_code: "times_html" }
].freeze

LOCATIONS = [
  { name: "New York" },
  { name: "Los Angeles" },
  { name: "Chicago" },
  { name: "Houston" },
  { name: "Philadelphia" },
  { name: "Phoenix" },
  { name: "San Antonio" },
  { name: "San Diego" },
  { name: "Dallas" },
  { name: "San Jose" },
  { name: "Austin" },
  { name: "Jacksonville" },
  { name: "San Francisco" },
  { name: "Indianapolis" },
  { name: "Columbus" },
  { name: "Fort Worth" },
  { name: "Charlotte" },
  { name: "Detroit" },
  { name: "El Paso" },
  { name: "Seattle" }
].freeze

def create_tree(root, depth)
  return root if depth.zero?

  children_count = Faker::Number.between 1, 3

  children = (1..children_count).map do
    root.children.create!(target_attrs(root.panel_provider_id))
  end

  children.each { |child| create_tree(child, depth - 1) }
end

def target_attrs(provider_id)
  { panel_provider_id: provider_id,
    name: Faker::Lorem.word,
    external_id: SecureRandom.uuid,
    secret_code: SecureRandom.hex(64) }
end

PANEL_PROVIDERS_CODES.each { |panel_provider_code| PanelProvider.create!(code: panel_provider_code) }

COUNTRIES.each do |country|
  Country.create!(
    code: country.fetch(:code),
    panel_provider: PanelProvider.find_by!(code: country.fetch(:panel_provider_code))
  )
end

LOCATIONS.each do |location|
  Location.create!(
    name: location.fetch(:name),
    external_id: SecureRandom.uuid,
    secret_code: SecureRandom.hex(64)
  )
end

# create target & location groups
root_target_groups = []
us_company_id = Country.find_by!(code: 'US').id # as all locations in us

PanelProvider.all.ids.cycle do |provider_id|
  LocationGroup.create!(
    panel_provider_id: provider_id,
    country_id: us_company_id,
    name: Faker::Lorem.word)

  root_target_groups << TargetGroup.create(target_attrs(provider_id))

  break if root_target_groups.size == 4
end

root_target_groups.each { |trgt| create_tree(trgt, 3) }

# create some records for many to many relation between location and location group
location_groups = LocationGroup.all.to_a

Location.find_in_batches(batch_size: 5) do |batch|
  location_group = location_groups.pop
  location_group.locations << batch
  location_group.save!
end