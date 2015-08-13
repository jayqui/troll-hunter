# require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'uri'

site = "www.yelp.com"
http = Net::HTTP.new(site)
req = Net::HTTP::Get.new("/biz/alinea-chicago", {'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.130 Safari/537.36'})

response = http.request(req)

open('alinea_noko.html','a+') do |f|
  f.puts "\n" + response.body
end

# num_reviews =
# "review-count rating-qualifier"
# (num_reviews / 40).times do |i|
33.times do |i|
  http = Net::HTTP.new(site)
  req = Net::HTTP::Get.new("/biz/alinea-chicago?start=#{i*40}", {'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.130 Safari/537.36'})

  response = http.request(req)

  open('alinea_noko.html','a+') do |f|
    f.puts "\n" + response.body
  end
end


@alinea = Nokogiri::HTML(File.open('alinea_noko.html'))
