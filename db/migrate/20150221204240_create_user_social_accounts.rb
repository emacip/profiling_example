class CreateUserSocialAccounts < ActiveRecord::Migration
  def change
    create_table :user_social_accounts do |t|
      t.references :user, index: true
      t.references :social_account, index: true

      t.timestamps
    end
  end
end
