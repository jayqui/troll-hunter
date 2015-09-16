get '/restaurants' do
  @restaurants = Restaurant.all.sort_by{|restaurant| restaurant.reviews.count}
  erb :"restaurants/index"
end

get '/restaurants/:id' do
  @restaurant = Restaurant.find(params[:id])
  erb :"restaurants/show"
end


