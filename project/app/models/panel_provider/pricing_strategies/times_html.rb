module PanelProvider::PricingStrategies
  class TimesHtml
    URL = 'http://time.com'

    def calc
      html_page = RemotePage.new(URL).fetch_and_parse(:html)

      html_page.css('*').count
    end
  end
end