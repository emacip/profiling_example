class AddSocialAccountTypeToSocialAccounts < ActiveRecord::Migration
  def change
    add_reference :social_accounts, :social_account_type
  end
end
