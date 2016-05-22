require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @unknown = {
      "uid" => "unknown_user",
      "provider" => "spotify",
      "info" => {"name" => "unknown user" , "image" => "http://www.lol.com", "urls" => {"spotify" => "http://spotify-user-url"}}
    }
    @known = {
      "uid" => "known_user",
      "provider" => "spotify",
      "info" =>  {"name" => "known user" , "image" => "http://www.lol.com", "urls" => {"spotify" => "http://spotify-user-url"}}
    }
    @unknown_with_uid = OmniAuth.config.mock_auth[:spotify_uid]
  end

  test "can make a new user given the oauth spotify hash of unknown user" do
    assert_difference 'User.count', 1 do
      @user = User.find_or_create_from_omniauth @unknown
    end
  end

  test "can find an existing user given an oauth spotify hash" do
    assert_equal users(:known_user), User.find_or_create_from_omniauth(@known)
  end

  test "uses oauth data to set user name, provider and uid for new users" do
   user = User.find_or_create_from_omniauth @unknown

   assert_equal @unknown['info']['name'], user.name
   assert_equal @unknown['provider'], user.provider
   assert_equal @unknown['uid'], user.uid
  end

  test "validations: username cannot be empty string" do
    user = User.new
    user.name = ""
    assert_not user.valid?
    assert user.errors.keys.include?(:name), "name is not in the errors hash"
  end

  test "validation: provider must be spotify" do
    user = User.new
    user.provider = "rectify"
    assert_not user.valid?
    assert user.errors.keys.include?(:provider), "provider is not in the errors hash"
  end


  test "validation: provider must be present" do
    user = User.new
    assert_not user.valid?
    assert user.errors.keys.include?(:provider), "provider is not the errors hash"
  end

  test "validation: uid must be present" do
    user = User.new
    assert_not user.valid?
    assert user.errors.keys.include?(:uid), "uid is not in the errors hash"
  end

end
