get '/restaurants' do
  @restaurants = Restaurant.all.sort {|restaurant| restaurant.reviews.count}[0..9]
  erb :"restaurants/index"
end

get '/restaurants/:id' do
  @restaurant = Restaurant.find(params[:id])
  erb :"restaurants/show"
end


