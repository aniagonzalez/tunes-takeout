class OmniAuthUser < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string       # for the unique user identifier from the provider
    add_column :users, :provider, :string   # for the provider name
  end
end
