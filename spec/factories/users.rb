FactoryBot.define do
  factory :user do
    username Faker::HitchhikersGuideToTheGalaxy.character.delete(" ").underscore
    email { Faker::Internet.free_email(username) }
  end
end