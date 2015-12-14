require 'pry-byebug'

module TracksFromYoutubeHelper

def get_mix_urls(browser, num_of_mixes)
    links_array = []
    sidebar = browser.div(:id, 'watch7-sidebar-modules')
    bars = sidebar.divs(:class, 'watch-sidebar-section')
    # binding.pry
    bars.each do |bar|
        list = bar.ul(:class, 'video-list').lis  
        list.each do |item|
            if item.text.length > 0 
                href = item.link(:index, 0).attribute_value('href')
                if links_array.include? href
                    puts 'idk'
                else
                 links_array << href
                end
            end
        end
    end
    until links_array.size == num_of_mixes
        links_array.pop
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
        mix_num += 1
    end
    tracklist
end

end
