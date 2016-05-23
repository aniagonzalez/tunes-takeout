require 'test_helper'

class MusicTest < ActiveSupport::TestCase

	describe Music do

		describe "music object information", :vcr do
			before do
				@suggestion = {
          "id"=>"Vz0KQY-RRwADboFN",
					"food_id"=>"emerald-city-fish-and-chips-seattle",
					"music_id"=>"18nhNX9AEFPINp1txOsaJS",
					"music_type"=>"album"
					}

	    	@music_object = Music.find(@suggestion["music_id"], @suggestion["music_type"])
			end

      it "can find in spotify name of an album", :vcr do
        assert_equal "10 Years of Cream Pie 2005 - 2015", @music_object.name
      end

    end
    
 end

end
