require "securerandom"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

sat = []
sat << SocialAccountType.where(name: "FriendFace").first_or_create
sat << SocialAccountType.where(name: "Chirpr").first_or_create
sat << SocialAccountType.where(name: "Bilbo").first_or_create

# Create users, social accounts
FIRST_NAMES = [ "John", "Paul", "Thomas", "James", "Jake", "Matt", "Elizabeth", "Andrea", "Anna", "Victoria", "Roisin", "Kate" ]
LAST_NAMES = [ "Boyle", "Smith", "Dunne", "Kenny", "O'Connell", "Murphy", "Taylor", "McCann" ]

100.times do |i|
  user_sat = sat.dup.shuffle
  name = [FIRST_NAMES.sample, LAST_NAMES.sample]
  # create user
  u = User.create(
    name: name.join(" "),
    email: name.join(".") + "@gmail.com",
    age: rand(18..50)
  )
  # create social account(s)
  u.social_accounts.create(
    social_id: SecureRandom.uuid,
    social_name: "#{name[0]}-#{u.id}",
    social_account_type: user_sat.pop
  )
  if rand(10) % 2
    u.social_accounts.create(
      social_id: SecureRandom.uuid,
      social_name: "#{name[0]}-#{u.id}",
      social_account_type: user_sat.pop
    )
  end
end
