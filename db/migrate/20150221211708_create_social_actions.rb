class CreateSocialActions < ActiveRecord::Migration
  def change
    create_table :social_actions do |t|
      t.string :action_type
      t.string :value
      t.references :social_account, index: true

      t.timestamps
    end
  end
end
