get '/' do
  @restaurants = Restaurant.all.sort_by{|restaurant| restaurant.reviews.count}.reverse[0..9]
  erb :index
end
