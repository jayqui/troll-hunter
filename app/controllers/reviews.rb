get '/reviews' do
  p @reviews = Review.order("combined_score DESC").limit(10)
  erb :"reviews/index"
end
