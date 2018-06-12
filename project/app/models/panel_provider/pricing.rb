class PanelProvider::Pricing
  attr_reader :strategy

  def initialize(panel_provider)
    @code = panel_provider.code
    set_pricing_strategy
  end

  def price
    Rails.cache.fetch(strategy.name, expires_in: 2.minute) do
      strategy.new.calc
    end
  end


  def set_pricing_strategy
    @strategy ||=
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