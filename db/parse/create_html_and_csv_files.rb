require_relative "find_urls"
# require "nokogiri"
# require "net/http"
# require "uri"
# require "csv"

urls = ["ninis-deli-chicago","chicago-pizza-tours-chicago","somethin-sweet-donuts-chicago-3"]

### PUT HTML INTO NEW HTML FILES
def scrape(name, query_param = "")
  Net::HTTP::Get.new("/biz/#{name}#{query_param}", {"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.130 Safari/537.36"})
end

def create_html_file(url)
  html_file = Nokogiri::HTML(File.open("db/html_files/#{url}.html"))
end
# FIND THE NUMBER OF THE REVIEWS BASED ON THE FRONT PAGE

def find_num_of_reviews(html_file)
  html_file.search(".review-count > span")[0].inner_text
end

def find_restaurant_name(html_file)
  html_file.search(".biz-page-title")[0].inner_text
end

urls.each do |url|
  site = "www.yelp.com"
  http = Net::HTTP.new(site)
  req = scrape(url)

  response = http.request(req)

# CREATE FILE AND APPEND THE FIRST PAGE
  out_file = File.new("db/html_files/#{url}.html", "w")
  out_file.puts(response.body)
  out_file.close

  html_file = create_html_file(url)

# APPEND THE REST OF THE REVIEWS USING QUERY PARAMETERS
  num_reviews = find_num_of_reviews(html_file).to_i

  ((num_reviews / 40) -1).times do |i|
    req = scrape(url,"?start=#{i*40}")
    response = http.request(req)

    open("db/html_files/#{url}.html","a+") do |f|
      f.puts "\n" + response.body
    end
  end

  # CREATE CSV FILE FROM NOKOGIRI OBJECT
  populated_html = Nokogiri::HTML(File.open("db/html_files/#{url}.html"))

  reviews_array = populated_html.search(".review-content > p").map {|review| review.inner_text}
  reviews_array.uniq!
  restaurant_name = find_restaurant_name(html_file).strip

  p reviews_array.count

  CSV.open("db/csv_files/#{url}.csv", "wb") do |csv|
    csv << [restaurant_name]
    reviews_array.each do |review|
      csv << [review]
    end
  end


end


