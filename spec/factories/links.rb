FactoryBot.define do
  factory :link do
    url { FFaker::Internet.http_url }
    shortened_url { FFaker::Lorem.characters[0..5] }
  end
end
