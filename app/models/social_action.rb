class SocialAction < ActiveRecord::Base
  TYPES = ["checkin", "image", "post"]
  has_one :social_account
end
