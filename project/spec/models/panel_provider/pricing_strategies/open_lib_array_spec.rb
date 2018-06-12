require 'rails_helper'
require 'models/panel_provider/pricing_strategies/response_mock'

describe PanelProvider::PricingStrategies::OpenLibArray do
  describe '#calc' do
    subject { described_class.new.calc }

    context 'contains more than array > 10 in different nesting levels' do
      let(:web_response) do
        <<-RES
        {
        	"x": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
        	"y": {
        		"a": [1, 2, 3],
        		"b": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11]
        	},
        	"z": [1, 2, 3, {
        		"g": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11]
        	}]
        }
        RES
      end

      it 'count arrays with more than 10 elements ' do
        mock_response

        expect(subject).to eq(3)
      end
    end

    context 'no array with more than 10 elements' do
      let(:web_response) { '{"x":[]}' }

      it 'returns 1' do
        mock_response
        expect(subject).to eq(0)
      end
    end
  end



end