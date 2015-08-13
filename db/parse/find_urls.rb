require "nokogiri"
require "net/http"
require "uri"
require "csv"

def scrape(query_param = "")
  sleep(1)
  Net::HTTP::Get.new("/search?cflt=restaurants&find_loc=Chicago%2C+IL%2C+USA#{query_param}", {"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.130 Safari/537.36"})
end

site = "www.yelp.com"
http = Net::HTTP.new(site)
req = scrape

response = http.request(req)

out_file = File.new("db/restaurant_search_results/results.html", "w")
out_file.puts(response.body)
out_file.close

19.times do |i|
  req = scrape("#find_desc&start=#{i * 10}")
  response = http.request(req)

  open("db/restaurant_search_results/results.html", "a+") do |f|
    f.puts "\n" + response.body
  end
end

restaurant_results = Nokogiri::HTML(File.open("db/restaurant_search_results/results.html"))

@restaurant_array = restaurant_results.css(".biz-name").map {|link| link['href'].sub(/\/biz\//, "") }


p @restaurant_array


