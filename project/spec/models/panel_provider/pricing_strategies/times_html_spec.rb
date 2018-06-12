require 'rails_helper'
require 'models/panel_provider/pricing_strategies/response_mock'


describe PanelProvider::PricingStrategies::TimesHtml do
  describe '#calc' do
    subject { described_class.new.calc }

    context '3 html tags nodes and text node' do
      let(:web_response) { '<html><body><a>link<a><body></html>' }

      it 'returns the the number of all html nodes' do
        mock_response

        expect(subject).to eq(4)
      end
    end

    context 'only the html node' do
      let(:web_response) { '<html></html>' }

      it 'returns 1' do
        mock_response
        expect(subject).to eq(1)
      end
    end
  end
end