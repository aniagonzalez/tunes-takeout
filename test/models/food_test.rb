require 'test_helper'

class FoodTest < ActiveSupport::TestCase

	describe Food do

		describe "Business information", :vcr do
			before do
				@suggestion = {
          "id"=>"Vz0KQY-RRwADboFN",
					"food_id"=>"emerald-city-fish-and-chips-seattle",
					"music_id"=>"18nhNX9AEFPINp1txOsaJS",
					"music_type"=>"album"
					}

	    	@business = Food.find(@suggestion["food_id"])
			end

			it "can find a business on yelp using name", :vcr do
				assert_equal "Emerald City Fish & Chips", @business.name
			end


		end
	end

end
