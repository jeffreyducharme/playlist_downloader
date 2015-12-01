require '../track_scraper.rb'
require '../webdriver_helper.rb'
require 'watir-webdriver'
require 'pry'

file = '/Users/jducharme/Desktop/test.txt'
tracks = TrackScraper.new(file)
got_tracks = tracks.get_track_list_from_youtube_mix

pp got_tracks

b = Watir::Browser.new
url = 'vibeclouds.net'

b.goto(url)

search_input = b.text_field(:name, 'search')
search_btn = b.input(:class, 'searchButton')
results = b.ul(:class, 'results')
binding.pry

got_tracks.each_value do |v|
	search_input.set "#{v[:artist]} #{v[:track]}"
	sleep(1)
	search_btn.click
	sleep(1)
	no_extra_tabs(b, url)
	if results.text.include? v[:track]
		puts "found #{v[:artist]} #{v[:track]}"
	else 
		puts "this isn't working"
	end
end

b.close