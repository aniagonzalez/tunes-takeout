require 'test_helper'
require "TunesTakeoutWrapper"

class TunesTakeoutWrapperTest < ActiveSupport::TestCase

  describe TunesTakeoutWrapper do

    it "uses v1 of the API" do
      assert_equal "https://tunes-takeout-api.herokuapp.com/v1", TunesTakeoutWrapper::BASE_URL
    end

    describe "API", :vcr do
      before do
        @search = TunesTakeoutWrapper.search("tacos")
        @suggestion = TunesTakeoutWrapper.find("Vz0KO4-RRwADbn9t")
        @top_suggestions = TunesTakeoutWrapper.top
      end

      it "returns the suggestion hash when given a suggestion id", :vcr do
        assert_kind_of Hash, @suggestion
      end

      it "can retrieve the top favorited 20 suggestions", :vcr do
        assert_equal 20, @top_suggestions["suggestions"].length
      end

      it "can return 20 suggestions after user search", :vcr do
        assert_equal 20, @search["suggestions"].length
      end

      it "can return suggestions that include the search term", :vcr do
        assert true, @search.include?("tacos")
      end

      it "can add a favorite suggestion to a user", :vcr do
        TunesTakeoutWrapper.add_favorite("user1", "Vz0KO4-RRwADbn9f")
        user1_favorites = TunesTakeoutWrapper.favorites("user1")

        assert true, user1_favorites.include?("Vz0KO4-RRwADbn9f")
      end

      it "can delete a favorite suggestion from a user", :vcr do
        TunesTakeoutWrapper.add_favorite("user2", "Vz0KO4-RRwADbn9f")
        user2_favorites = TunesTakeoutWrapper.favorites("user2")["suggestions"].count
        TunesTakeoutWrapper.remove_favorite("user2", "Vz0KO4-RRwADbn9f")
        user2_favorites_after_delete = TunesTakeoutWrapper.favorites("user2")["suggestions"].count

        assert_equal user2_favorites, 1
        assert_equal user2_favorites_after_delete, 0
      end

    end
  end
end
