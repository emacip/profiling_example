class SocialAccount < ActiveRecord::Base
  has_one :user_social_account
  has_one :user, through: :user_social_account
  has_many :social_actions

  belongs_to :social_account_type

  accepts_nested_attributes_for :social_actions
end
