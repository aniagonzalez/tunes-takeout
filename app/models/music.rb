# attribute	data type	description
# item_id	string	Spotify-specific ID, which can be used in conjunction with the type to make calls to the Spotify API
# type	string	Which type of resource this item is. Can be: artist, album, track, playlist
# name	string	Name of the item
# url	string	URL for opening this item in a browser-based Spotify player
# image_url	string	URL of the photo to display for this item


require 'rspotify'

class Music
  BASE_URL = "http://"
  attr_reader :item_id, :type, :name, :url, :image_url

  def initialize(data)
    @item_id = data.id
    @type = data.type
    @name = data.name
    @url = data.external_urls["spotify"]
    if data.type == "album" || data.type == "artist"
      @image_url = data.images.first["url"] if !data.images.empty?
    end
    @image_url = data.album.images.first["url"] if data.type == "track" #first is widest image
  end

  def self.find(id, type)
    if type == "album"
      data = RSpotify::Album.find(id)
      self.new(data)
    elsif type == "track"
      data = RSpotify::Track.find(id)
      self.new(data)
    elsif type == "artist"
      data = RSpotify::Artist.find(id)
      self.new(data)
    end

  end

end

# @music.external_urls["spotify"]  <= to listen to track!
