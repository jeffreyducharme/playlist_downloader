module TracksFromYoutubeHelper

def get_mix_urls(browser, num_of_mixes)
    i = 1
    links_array = []
    sidebar = browser.div(:id, 'watch7-sidebar-modules')
    bars = sidebar.divs(:class, 'watch-sidebar-section')
    bars.each do |bar|
        list = bar.ul(:class, 'video-list').lis
        until i == num_of_mixes do 
            list.each do |item|
                if item.text.length > 0 
                    links_array << item.link(:index, 0).attribute_value('href')
                end
                i += 1
            end
        end
    end
    links_array
end

def goto_video_get_tracks(browser, url_list, mix_num = 1, tracklist = {})
    url_list.each do |url|
        browser.goto(url)
        sleep(3)
        # b.button(:class, 'ytp-play-button ytp-button').click
        browser.span(:text, 'Show more').click
        #scrap tracklist 

        tracklist["mix_#{mix_num}"] = {}
        tracklist["mix_#{mix_num}"][:url] = browser.url
        tracklist["mix_#{mix_num}"][:mix_title] = browser.span(:id, 'eow-title').text
        tracklist["mix_#{mix_num}"][:mix_description] = browser.div(:id, 'watch-description-text').text
        tracklist["mix_#{mix_num}"][:tracks] = {}
        track_num = 1 

        tracklist["mix_#{mix_num}"][:mix_description].each_line do |line|
            if line.include? '-'
                tracklist["mix_#{mix_num}"][:tracks][track_num] = line
                track_num += 1
            end
        end
        
        puts tracklist["mix_#{mix_num}"][:mix_title]
        puts tracklist["mix_#{mix_num}"][:url]
        puts tracklist["mix_#{mix_num}"][:tracks]
        mix_num += 1
    end
    tracklist
end

end
