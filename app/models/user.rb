class User < ActiveRecord::Base
  has_many :user_social_accounts
  has_many :social_accounts, through: :user_social_accounts

  accepts_nested_attributes_for :social_accounts
end
