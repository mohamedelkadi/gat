module PanelProvider::PricingStrategies
  class OpenLibArray
    URL = 'http://openlibrary.org/search.json?q=the+lord+of+the+rings'

    def calc
      res = RemotePage.new(URL).fetch_and_parse

      arrays_count(res)
    end

    private

    def arrays_count(obj)
      count = 0
      case obj
      when Hash
        obj.values.each { |el| count += arrays_count(el) }
      when Array
        count +=1 if obj.size > 10
        obj.each { |el| count += arrays_count(el) }
      end

      count
    end
  end
end