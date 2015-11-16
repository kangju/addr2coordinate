require "open-uri"
require 'rexml/document'

URL = "http://www.geocoding.jp/api/"

Location = Struct.new(:location,:lat,:lon)

locations = %w(一社 名古屋駅).map do |addr|
   doc = REXML::Document.new(open(URI.encode(URL + "?q=" + addr)))
   result =  doc.elements['result']
   location = result.elements['address'].text
   coordinate = result.elements['coordinate']
   lat = coordinate.elements['lat'].text
   lon = coordinate.elements['lng'].text
   Location.new(location,lat,lon)
end

puts locations