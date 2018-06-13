FactoryBot.define do
  factory :target_group do
    external_id { SecureRandom.uuid }
    secret_code { SecureRandom.hex(64) }
  end
end