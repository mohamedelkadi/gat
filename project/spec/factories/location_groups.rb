FactoryBot.define do
  factory :location_group do
    country
    panel_provider
    name { Faker::Lorem.word }
  end
end