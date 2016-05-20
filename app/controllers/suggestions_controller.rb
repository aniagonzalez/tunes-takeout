require_relative '../../lib/TunesTakeoutWrapper.rb'
require 'yelp'
require 'httparty'

class SuggestionsController < ApplicationController
  # extend TunesTakeoutWrapper

  def index
    #shows top 20 suggestions, ranked by total number of favorites
    suggestion_ids = TunesTakeoutWrapper.top["suggestions"] #this should return array of sugg ids


    @pairings = []
    suggestion_ids.each do |suggestion_id|

      suggestion_object = TunesTakeoutWrapper.find(suggestion_id)

      suggestion = suggestion_object["suggestion"]

      yelp_id = suggestion["food_id"]
      spotify_id = suggestion["music_id"]
      spotify_type = suggestion["music_type"]

      array = []
      array << Food.find(yelp_id)  #first thing in array is yelp
      array << Music.find(spotify_id, spotify_type) #second thing is music

      @pairings << array
    end
  end

  def favorites
    #shows all suggestions favorited by the signed-in User

  end

  def search_by_term
    #Returns a hash from the TunesTakeoutWrapper
  end

  def display_results
    results = TunesTakeoutWrapper.search(params[:term])
    suggestions = results["suggestions"]


    @pairings = []
    suggestions.each do |suggestion|

      yelp_id = suggestion["food_id"]
      spotify_id = suggestion["music_id"]
      spotify_type = suggestion["music_type"]

      array = []
      array << Food.find(yelp_id)  #first thing in array is yelp
      array << Music.find(spotify_id, spotify_type) #second thing is music
      @pairings << array

    end

  end

  def favorite
    #adds a suggestion into the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.

  end

  def unfavorite
    #removes a suggestion from the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API

  end

end
