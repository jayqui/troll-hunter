require_relative 'nokogiri_test'
require 'csv'

reviews_array = @alinea.search(".review-content > p").map {|review| review.inner_text}
reviews_array.uniq!
p reviews_array.count

CSV.open("db/csv_files/#{reviews_array}.csv", "wb") do |csv|
  reviews_array.each do |review|
    csv << [review]
  end
end




