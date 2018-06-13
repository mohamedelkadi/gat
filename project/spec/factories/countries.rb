FactoryBot.define do
  factory :country do
    code { Faker::Address.country_code }
    panel_provider
  end
end