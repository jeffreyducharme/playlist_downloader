require 'watir-webdriver'
require '../webdriver_helper.rb'
require '../tracks_from_youtube/tracks_from_youtube_helper'
require '../track_scraper.rb'
require 'pry-byebug'
extend TracksFromYoutubeHelper
extend WebdriverHelper 
#magic happening 

begin
    url = 'https://www.youtube.com/watch?v=5b9PRVUwKp0'

    b = Watir::Browser.new
    b.goto(url)
    sleep(3)
    # turn off video, open show more
    
    url_list = get_mix_urls(b, 10)
    url_list = url_list.unshift(url)
    # binding.pry
    tracklist = goto_video_get_tracks(b, url_list, mix_num = 1, tracklist = {})

    tracks = TrackScraper.new(tracklist)
    # binding.pry
    got_tracks = tracks.get_track_list_from_youtube_mix
   
    pp got_tracks

ensure
    b.close
end