class CreateSocialAccountTypes < ActiveRecord::Migration
  def change
    create_table :social_account_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
