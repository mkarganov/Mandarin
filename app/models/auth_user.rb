class AuthUser < ActiveRecord::Base
  has_many :authorizations, :foreign_key => :user_id
  set_table_name "users"
  attr_accessible :email, :name

  validates :name, :presence => :true
  validates :email, :presence => :true, :uniqueness => :true, :on => :update
  def add_provider(auth_hash)
  # Check if the provider already exists, so we don't add it twice
  unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    authorizations.create :provider => auth_hash["provider"], :uid => auth_hash["uid"]
  end
end


end
