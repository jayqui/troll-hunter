get '/reviews' do
  @reviews = Review.order("combined_score DESC").limit(10)
  erb :"reviews/index"
end
