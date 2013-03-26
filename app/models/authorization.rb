class Authorization < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id
  belongs_to :user

  validates :provider, :uid, :presence => true

  scope :find_by_auth, lambda { |auth_hash| where("provider = ? AND uid = ?" , auth_hash["provider"], auth_hash["uid"]) }

  #def self.find_(auth_hash)
    #find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  #end
  def self.create_(auth_hash)
    user = AuthUser.create :name => auth_hash["info"]["name"], "email" => auth_hash["info"]["email"]
    auth = create :user_id => user.id, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
  end
end
