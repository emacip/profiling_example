class SocialAccount < ActiveRecord::Base
  has_one :user_social_account
  has_one :user, through: :user_social_account
end
