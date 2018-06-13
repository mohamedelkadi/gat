require 'rails_helper'

describe 'POST evaluate_target' do
  context 'unauthenticated' do
    it 'needs authentication' do
      post '/v1/private/evaluate_target', {}

      expect(response).to have_http_status(401)
    end
  end

  context 'authenticated' do
    let(:user) { create :user }
    let(:headers) do
      { 'HTTP_AUTHORIZATION' =>
          "Token token=\"#{user.authentication_token}\", email=\"#{user.email}\"" }
    end
    let(:incomplete_params) do
      { country_code: 'US',
        target_group_id: 1 }
    end

    context 'bad params' do

      it 'fails with missing param' do
        post '/v1/private/evaluate_target', params: incomplete_params, headers: headers

        expect(response).to have_http_status(422)
      end
    end

    context 'valid params' do
      let(:provider) { create :panel_provider, code: 'times_a' }
      let(:country) { create :country, code: 'US', panel_provider_id: provider.id }
      let(:target_group) { create :target_group, panel_provider_id: provider.id }
      let(:locations) { create_list :location, 5 }
      let(:valid_params) do
        {
          country_code: country.code,
          target_group_id: target_group.id,
          locations: locations.map { |loc| { id: loc.id, size: 1 } }
        }
      end

      before do
        country.target_groups << target_group
        country.save!
      end

      it 'get the correct price for correct params' do
        stub_request(:get, "http://time.com/").
          with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Host' => 'time.com',
              'User-Agent' => 'Ruby'
            }).
          to_return(status: 200, body: "<html>aa</html>", headers: {})

        post '/v1/private/evaluate_target', params: valid_params, headers: headers

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq('{"price":10}')
      end
    end
  end
end