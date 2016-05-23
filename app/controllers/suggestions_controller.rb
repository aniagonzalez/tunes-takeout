require_relative '../../lib/TunesTakeoutWrapper.rb'
require 'yelp'
require 'httparty'

class SuggestionsController < ApplicationController
#skip before action

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

      if current_user
        favorite = is_favorite?(suggestion["id"])
      end


      array = []
      array << Food.find(yelp_id)  #first thing in array is yelp
      array << Music.find(spotify_id, spotify_type) #second thing is music
      array << suggestion["id"]
      if favorite
        array << favorite
      end 

      @pairings << array
    end
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

      favorite = is_favorite?(suggestion["id"])

      array = []
      array << Food.find(yelp_id)  #first thing in array is yelp
      array << Music.find(spotify_id, spotify_type) #second thing is music
      array << suggestion["id"]
      array << favorite

      @pairings << array

    end

  end

  def favorite
    #adds a suggestion into the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
    TunesTakeoutWrapper.add_favorite(current_user.uid, params[:suggestion_id])
    redirect_to root_path
  end

  def unfavorite
    #removes a suggestion from the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API
    TunesTakeoutWrapper.remove_favorite(current_user.uid, params[:suggestion_id])
    redirect_to root_path
  end

  def is_favorite?(suggestion_id)
    favorites_response = TunesTakeoutWrapper.favorites(current_user.uid)
    user_favorites = favorites_response["suggestions"]  #an array
    return user_favorites.include? suggestion_id
  end

  def favorites
    favorites_response = TunesTakeoutWrapper.favorites(current_user.uid)
    suggestion_ids = favorites_response["suggestions"] #this is array of suggestion_ids

    @pairings = []
    suggestion_ids.each do |suggestion_id|

      suggestion_object = TunesTakeoutWrapper.find(suggestion_id)
      suggestion = suggestion_object["suggestion"]

      yelp_id = suggestion["food_id"]
      spotify_id = suggestion["music_id"]
      spotify_type = suggestion["music_type"]

      favorite = is_favorite?(suggestion["id"])

      array = []
      array << Food.find(yelp_id)  #first thing in array is yelp
      array << Music.find(spotify_id, spotify_type) #second thing is music
      array << suggestion["id"]
      array << favorite

      @pairings << array
    end


  end

end
