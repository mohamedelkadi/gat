FactoryBot.define do
  factory :panel_provider do
    code { %w(times_a 10_arrays times_html).sample }
  end
end