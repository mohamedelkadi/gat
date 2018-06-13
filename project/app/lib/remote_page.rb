# frozen_string_literal: true

class RemotePage
  def initialize(url)
    @url = url
  end

  def fetch_and_parse(format = :json)
    result = fetch

    case format
    when :json
      JSON.parse(result)
    when :html
      Nokogiri.HTML(result)
    else
      raise ArgumentError, "Unsupported format #{format} "
    end
  end

  def fetch
    Net::HTTP.get URI(@url)
  end
end
