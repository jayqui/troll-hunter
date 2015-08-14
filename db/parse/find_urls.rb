require "nokogiri"
require "net/http"
require "uri"
require "csv"

def scrape(query_param = "")
  Net::HTTP::Get.new("/search?cflt=restaurants&find_loc=Chicago%2C+IL%2C+USA#{query_param}", {"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.130 Safari/537.36"})

end

site = "www.yelp.com"
http = Net::HTTP.new(site)
req = scrape
response = http.request(req)

19.times do |i|
  sleep(1)
  next_request = scrape("&start=#{i * 10}")
  response_two = http.request(next_request)

  open("db/restaurant_search_results/results.html", "a+") do |f|
    f.puts "\n" + response_two.body
  end
end

restaurant_results = Nokogiri::HTML(File.open("db/restaurant_search_results/results.html"))

@restaurant_array = restaurant_results.css(".biz-name").map do |link|
  link['href'].sub(/\/biz\//, "")
end

@restaurant_array.uniq!
