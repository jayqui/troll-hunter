get '/reviews' do
  @reviews = Review.sort_by_combined_score
  erb :"reviews/home"
end
