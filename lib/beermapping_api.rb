class BeermappingApi

  def self.places_in(city)
    #api_key = "15578b7be01286ed23c388e294580aa6"
    url = "http://stark-oasis-9187.herokuapp.com/api/"
    #url = "http://beermapping.com/webservice/loccity/#{api_key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, location|
        set << Place.new(location)
    end
  end
end