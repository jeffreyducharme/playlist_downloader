class TrackScraper

	attr_accessor :file, :hash

	def initialize(file)
		@file = File.open(file)
		@hash = {}
	end

	def get_track_list_from_youtube_mix
		hash = @hash
		track_num = 1
		@file.each_line do |line|
			puts line
			clean_artist = false
			clean_track = false
			artist, track = split_artist_track(line)
			until clean_artist == true
				artist, clean_artist = remove_numbers(artist)
			end 
			until clean_track == true 
				track, clean_track = remove_numbers(track)
			end
			hash[track_num] = {}
			hash[track_num][:artist] = artist
			hash[track_num][:track] = track
			track_num += 1
		end
		hash
	end

	def split_artist_track(string)
		string = string.gsub("\n","")
		if string.include? (' - ')
			artist, track = string.split(' - ')
		else 
			puts 'Could not split artist track'
			artist = 'Could not split artist track'
			track = string
		end
		[artist, track]
	end

	def remove_numbers(string)
		pattern = /[0-9]+. /
		pattern1 = / [0-9]+.[0-9]+/
		pattern2 = / [0-9]+.[0-9]+.[0-9]+/
		if string.match(pattern2)
			string = string.gsub(pattern2,'')
		elsif string.match(pattern1)
			string = string.gsub(pattern1,'')
		elsif string.match(pattern)
			string = string.gsub(pattern,'')
		else
			clean = true
		end
		[string, clean]
	end

end