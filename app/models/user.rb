class User < ActiveRecord::Base
  #User: A signed-in user account, created via OmniAuth and connected to a Spotify account.
  # Validations:
  # provider must be a string, must be present, and must equal spotify
  # uid must be a string, and must be present
  # name, if present, must be a string
  validates :uid, :provider, presence: true
  validate :provider_must_be_spotify
  validate :name_cant_be_empty_string

  def provider_must_be_spotify
    if provider != "spotify"
      errors.add(:provider, "provider must be spotify")
    end
  end

  def name_cant_be_empty_string
    if name == ""
      errors.add(:name, "name can't be empty string")
    end
  end


  def self.find_or_create_from_omniauth(auth_hash)
    # Find or create a user
    #user = User.where(uid: auth_hash["uid"]).where(provider: auth_hash["provider"]).first
    user = self.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])
    # user = //something else here//
    if !user.nil?
    #   return user that was found
      return user
    else
    #   no user found, do something here
      user = User.new
      user.uid = auth_hash["uid"]
      user.provider = auth_hash["provider"]
      user.name = auth_hash["info"]["name"]
      user.image = auth_hash["info"]["image"]
      user.url = auth_hash["info"]["urls"]["spotify"]
      if user.save
        return user
      else
        return nil
      end
    end
  end




end
