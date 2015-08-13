CSV.foreach("./db/parse/reviews_alinea.csv") do |review|
  Review.create(body:review,url:"www.yelp.com/biz/alinea-chicago")
end
