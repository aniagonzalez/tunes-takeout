# business_id	string	Yelp-specific ID, which can be used to make calls to the Yelp Business API to retrieve complete details
# name	string	Name of the business
# url	string	Yelp URL for this business
# image_url	string	URL of the photo to display for this business
# phone	string	Phone number for the business
# rating	decimal number	Average rating for this business based on Yelp reviews

require 'httparty'

class Food
  BASE_URL = "https://api.yelp.com/v2"
  attr_reader :business_id, :name, :url, :image_url, :phone, :rating

  def initialize(data)
    @business_id = data.business.id
    @name = data.business.name
    @url = data.business.url
    @image_url = data.business.image_url
    @phone = data.business.phone
    @rating = data.business.rating
  end

  def self.find(id)
    # https://api.yelp.com/v2/search?term=food
    #find a business with the passed term +++ NOT TERM, BUT business_id?
    #data = HTTParty.get(BASE_URL + "/search?term=#{term}").parsed_response
    data = Yelp.client.business(id)
    #return an array of instances of business for that term
    self.new(data)
  end

end
