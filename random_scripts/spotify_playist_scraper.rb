#from Spotify playlist, download
require 'pry'

require 'watir-webdriver'
require 'nokogiri'

#first, Navigate to spotify playlist url, login to Spotify if needed.

def sign_in(browser)
    if browser.text.include? 'Sign up'
        browser.link(:id,'has-account').click
        if browser.text.include? 'LOG IN WITH FACEBOOK'
            browser.link(:id,'fb-login-btn').click
            if browser.windows.length == 2
                facebook_login_window(browser)
            else 
                puts 'already signed into facebook and thus, signed into spotify'
            end
        end
    else
        puts 'already signed into spotify'
    end
end

#next, scrap Spotify Playist 

def facebook_login_window(browser)
    browser.window(:url,/facebook/).use
    browser.text_field(:id,'email').set 'jeffducharme@email.com'
    browser.text_field(:id,'pass').set 'stereo1234'
    browser.input(:name, 'login').click
    sleep(2)
    browser.window(:url,/spotify/).use
end

def get_spotify_pl_tbody(browser)
    main_frame = browser.iframe(:id,'main')
    plist_app = main_frame.iframe(:id,'app-playlist-desktop').body
    plist_table = plist_app.table(:class,'tracklist-playlist ')
    plist = plist_table.tbody
end

def scrape_list_output_list(list)
    song_hash = {}
    num = 1
    list.trs.each do |row|
        song = row.td(:class,'tl-cell tl-name').text
        artist = row.td(:class,'tl-cell tl-artists').text
        song_hash[num] = {'title' => song, 'artist' => artist}
        puts "processed row #{num}"
        num += 1  
    end
    song_hash
end

def search_on_vibecloud(browser, hash)
    dl_url = "http://vibeclouds.net/"
    browser.goto(dl_url)
    search_field = browser.text_field(:name,'search')
    search_btn = browser.button(:class,'searchButton')
    hash.each do |num, track|
        puts "searching for track number #{num}"
        artist = track['artist'] 
        title = track['title']
        @search_str = "#{artist} #{title}"
        search_field.set @search_str
        search_btn.click 
    end
end

def run

    sp_list_url = 'https://player.spotify.com/user/1211197232/playlist/1VazyqKeP01Z12Hgedn6wo'
    dl_url = "http://vibeclouds.net/"
    save_destination = ''

    b = Watir::Browser.new 

    b.goto(sp_list_url)


    sign_in(b)

    track_list = get_spotify_pl_tbody(b)

   # binding.pry

    #TODO speed this up with nokogiri
    hash = scrape_list_output_list(track_list)
    b = Watir::Browser.new 
    search_on_vibecloud(b,hash)
end




run
