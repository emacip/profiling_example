class CreateSocialAccounts < ActiveRecord::Migration
  def change
    create_table :social_accounts do |t|
      t.string :social_id
      t.string :social_name

      t.timestamps
    end
  end
end
