require 'watir-webdriver'
require 'pry'
require 'tracks_from_youtube'

tracks = TracksFromYoutube.new('/Users/jducharme/Desktop/test.txt')

got_tracks = TracksFromYoutube.get_track_list_from_youtube_mix

b = Watir::Browser.new

b.goto('vibecloud.net')

binding.pry