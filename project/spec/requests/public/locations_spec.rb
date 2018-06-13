require 'rails_helper'

describe 'GET  /v1/public/locations/:code', type: :request do
  let!(:provider1) { create :panel_provider, code: 'code1' }
  let!(:provider2) { create :panel_provider, code: 'code2' }
  # create two different countries
  let!(:country) { create :country, code: 'US', panel_provider: provider1 }
  let!(:other_country) { create :country, code: 'PL', panel_provider: provider2 }
  # create three different location
  let!(:location1) { create :location }
  let!(:location2) { create :location }
  let!(:location3) { create :location }
  # create two locations group with different providers
  let!(:locations_group1) { create :location_group, panel_provider: country.panel_provider }
  let!(:locations_group2) { create :location_group, panel_provider: other_country.panel_provider }

  before do
    # link the two location group to the main country
    country.location_groups << [locations_group1, locations_group2]
    # add location1 to location group with default panel provider of the country with code us
    locations_group1.locations << [location1]
    # add location2 to the other group with different panel provider
    locations_group2.locations << [location2]

    country.save!
    locations_group1.save!
    locations_group2.save!
  end

  let(:expected_response) { [location1].to_json }

  it "It should return locations which belong to the selected country based on it's current panel provider" do
    get '/v1/public/locations/us'
    expect(response.body).to eq(expected_response)
    expect(response).to have_http_status(:ok)
  end
end