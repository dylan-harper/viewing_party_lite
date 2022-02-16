FactoryBot.define do

  factory :user do
    name { Faker::Lorem.characters(number:5) }
    email { Faker::Lorem.characters(number:10) }
    password_digest { Faker::Lorem.characters(number:15) }
  end

  # factory :movie do
  #   db_id { Faker::Number.number(digits: 3) }
  #   title { Faker::Movie.title }
  #   poster_path { Faker::Lorem.characters(number:15) }
  #   genre_ids { Faker::Lorem.characters(number:5) }
  #   overview { Faker::Lorem.paragraph(sentence_count: 3) }
  #   vote_average { Faker::Number.number(digits: 1) }
  # end

  factory :party do
    duration { Faker::Number.number(digits: 3) }
    date { Faker::Lorem.characters(number: 8) }
    start_time { Faker::Number.number(digits: 3) }
    movie_id { Faker::Number.number(digits: 2) }
  end

  factory :user_party do
    status { "Invited" }
    user_id { Faker::Number.number(digits: 2) }
    party_id { Faker::Number.number(digits: 2) }
  end

end
