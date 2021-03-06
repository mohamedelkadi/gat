# frozen_string_literal: true

module PanelProvider::PricingStrategies
  class TimeA
    URL = 'http://time.com'

    def calc
      html_page = RemotePage.new(URL)
                            .fetch_and_parse(:html)

      html_page.search('body').text.count('a')
    end
  end
end
