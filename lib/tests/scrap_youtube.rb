require 'watir-webdriver'


def get_mix_urls(browser)
    links_array = []
    sidebar = browser.div(:id, 'watch7-sidebar-modules')
    bars = sidebar.divs(:class, 'watch-sidebar-section')
    bars.each do |bar|
        list = bar.ul(:class, 'video-list').lis
        list.each do |item|
            if item.text.length > 0 
                links_array << item.link(:index, 0).attribute_value('href')
            end
        end
    end
    links_array
end

#magic happening 

url = 'https://www.youtube.com/watch?v=5b9PRVUwKp0'

b = Watir::Browser.new
b.goto(url)
sleep(3)
# turn off video, open show more
url_list = get_mix_urls(b)
url_list = url_list.unshift(url)

mix_num = 1
tracklist = {}

url_list.each do |url|
    b.goto(url)
    sleep(3)
    b.button(:class, 'ytp-play-button ytp-button').click
    b.span(:text, 'Show more').click
    #scrap tracklist 

    tracklist["mix_#{mix_num}"] = {}
    tracklist["mix_#{mix_num}"][:url] = b.url
    tracklist["mix_#{mix_num}"][:mix_title] = b.span(:id, 'eow-title').text
    tracklist["mix_#{mix_num}"][:mix_description] = b.div(:id, 'watch-description-text').text
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

b.close
