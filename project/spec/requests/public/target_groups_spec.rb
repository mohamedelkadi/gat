require 'rails_helper'

describe 'GET /v1/public/target_groups/:code', type: :request do
  let!(:other_provider) { create :panel_provider, code: 'fake' }
  let!(:country) { create :country, code: 'US' }
  let!(:target_groups1) { create_list :target_group, 5, panel_provider: country.panel_provider }
  let!(:target_groups2) { create_list :target_group, 5, panel_provider: other_provider }

  before do
    country.target_groups = target_groups1
    country.target_groups << target_groups2
    country.save!
  end

  it "It should return target groups which belong to the selected country based on it's current panel provider" do
    get '/v1/public/target_groups/us'
    expect(response).to have_http_status(:ok)
    expect(response.body).to eq(target_groups1.to_json)
  end
end