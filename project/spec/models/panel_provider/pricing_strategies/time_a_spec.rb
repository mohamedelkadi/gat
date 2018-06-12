require 'rails_helper'
require 'models/panel_provider/pricing_strategies/response_mock'


describe PanelProvider::PricingStrategies::TimeA do
  describe '#calc' do
    subject { described_class.new.calc }

    context 'there is a letters' do
      let(:web_response) { '<html><body>aaa<a>link<a><body></html>' }

      it 'returns the the number  a without html tags' do
        mock_response

        expect(subject).to eq(3)
      end
    end

    context 'no a letters' do
      let(:web_response) { '<html><body><a></a><body></html>' }

      it 'returns 0' do
        mock_response
        expect(subject).to eq(0)
      end
    end
  end
end