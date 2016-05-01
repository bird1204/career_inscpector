class BadBoss
  attr_writer :name
  attr_reader :rate
  
  def initialize(name='')
    @name = name
    @rate = fetch_rate
  end

  private

  def fetch_rate
    return JSON.parse(Net::HTTP.get_response(URI.parse(URI.encode(url))).body)['rate']
  rescue StandardError => e
    return rand(0..10) * 10
  end

  def url
    "http://www.badboss.taipei/company/#{name}"
  end
end