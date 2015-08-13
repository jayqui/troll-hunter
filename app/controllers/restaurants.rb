get '/restaurants' do
  @restaurants = Restaurant.all
  erb :"restaurants/index"
end
