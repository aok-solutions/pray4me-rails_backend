FactoryBot.define do
  factory :prayer_request do
    subject Faker::HitchhikersGuideToTheGalaxy.specie
    description Faker::HitchhikersGuideToTheGalaxy.quote
  end
end