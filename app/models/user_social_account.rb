class UserSocialAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :social_account
end
