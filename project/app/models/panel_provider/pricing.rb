# frozen_string_literal: true

class PanelProvider::Pricing
  def initialize(panel_provider)
    @code = panel_provider.code
  end

  def price
    Rails.cache.fetch(pricing_strategy.name, expires_in: 2.minute) do
      pricing_strategy.new.calc
    end
  end

  def pricing_strategy
    @pricing_strategy ||=
      case @code
      when 'times_a'
        PanelProvider::PricingStrategies::TimeA
      when '10_arrays'
        PanelProvider::PricingStrategies::OpenLibArray
      when 'times_html'
        PanelProvider::PricingStrategies::TimesHtml
      end
  end
end
