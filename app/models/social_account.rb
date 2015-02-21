class SocialAccount < ActiveRecord::Base
  has_one :user_social_account
  has_one :user, through: :user_social_account

  belongs_to :social_account_type
end
