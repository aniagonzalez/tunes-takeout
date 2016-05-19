require 'httparty'

module TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/v1"

  def self.find(id)
    #/v1/suggestions/VzoikPLQUk2WS7xp
    HTTParty.get(BASE_URL + "/suggestions/" + id).parsed_response
  end

  def self.search(term, limit = 20)
    HTTParty.get(BASE_URL + "/suggestions/search?query=#{term}&limit=#{limit}").parsed_response
  end

  def self.top
    HTTParty.get(BASE_URL + "/suggestions/top").parsed_response
    # parsed response is hash ["suggestions"] has array with 20 suggestions
  end
end
