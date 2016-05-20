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

  def self.add_favorite(user_uid, suggestion_id)
    #/v1/users/:user_id/favorites
    HTTParty.post(BASE_URL+"/users/#{user_uid}/favorites",
      :body => {"suggestion": suggestion_id}.to_json)
  end
end
