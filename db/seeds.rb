# CSV.foreach("./db/parse/reviews_alinea.csv") do |review|
#   Review.create(body:review,url:"www.yelp.com/biz/alinea-chicago")
# end

 SEXY_WORDS = %w(sexy sex sexual voluptuous penis masturbation masturbate erotic come-hither sensuous suggestive titillating seductive racy inviting provacative mistress dick orgy)

  DRAMATIC_WORDS = %w(gross pathetic miserable tacky Kardashian jesus Jesus Christ ex-husband ex-wife ex-partner ex-boyfriend ex-girlfriend fuck damn shit cock bitch asshole asshat twerk terrible horrible 9/11 scum vile fecle)

require 'faker'

5.times do
  restaurant = Restaurant.create(name:"The restaurant of #{Faker::Name.name}")

  10.times do
    Review.create(body:"This restaurant is #{SEXY_WORDS.sample}",restaurant:restaurant)
  end

end
