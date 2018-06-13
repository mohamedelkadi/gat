require 'rails_helper'

describe Target do
  let!(:country) { create :country }
  let!(:target_group) { create :target_group, panel_provider: country.panel_provider }
  let!(:locations) { create_list :location, 5 }
  context 'when params is valid' do
    let(:valid_params) do
      {
        locations: locations.map { |loc| { id: loc.id, size: Faker::Number.number(3) } },
        target_group_id: target_group.id,
        country_code: country.code
      }
    end
    before do
      country.target_groups << target_group
      country.save!
    end

    it 'is valid and no error messages' do
      target = Target.new(valid_params[:country_code],
                          valid_params[:target_group_id],
                          valid_params[:locations])

      expect(target.valid?).to be_truthy
    end
  end

  context 'when params is invalid' do
    let(:invalid_params) do
      {
        locations: [{ id: -1, size: 1000 }],
        target_group_id: -1,
        country_code: -1,
      }
    end
    subject do
      Target.new(invalid_params[:country_code],
                 invalid_params[:target_group_id],
                 invalid_params[:locations])
    end

    it 'is not valid' do
      expect(subject.valid?).to be_falsey
    end

    it 'give 3 errors messages' do
      subject.valid?

      expect(subject.errors.size).to eq(3)
    end
  end
end