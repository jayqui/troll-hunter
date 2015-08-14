def create_seeds(file)
  return if file == "." || file == ".."
  restaurant = Restaurant.create(name: CSV.open("db/csv_files/#{file}",'r') {|csv| csv.first})

  CSV.foreach("db/csv_files/#{file}",headers:true) do |review|
    Review.create(body:review,restaurant_id:restaurant.id)
    Review.generate_scores
  end
end



Dir.foreach("db/csv_files") {|file| create_seeds(file) }

