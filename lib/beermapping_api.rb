class BeermappingApi

  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city,:expires_in => 1.weeks) { fetch_places_in(city) }
  end

  def self.fetch_places_in(city)

    url = "http://stark-oasis-9187.herokuapp.com/api/"
    #url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, location|
        set << Place.new(location)
    end
  end

  def self.fetch_pubs(city)
    Rails.cache.read(city)
  end

  def self.key
    Settings.beermapping_apikey
  end

end
#api_key = "15578b7be01286ed23c388e294580aa6"