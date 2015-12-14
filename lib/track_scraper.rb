class TrackScraper

	attr_accessor :tracks_hash, :hash

	def initialize(tracks_hash)
		#@file = File.open(file)
		@tracks_hash = tracks_hash
		@hash = {}
	end

	def get_track_list_from_youtube_mix
		hash = @hash
		# track_num = 1
        # binding.pry
		@tracks_hash.each do |key, value|
			value[:tracks].each do |track_num, track_text|
				clean_artist = false
				clean_track = false
				if is_track?(track_text, 150)
					artist, track = split_artist_track(track_text)
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
				else
					puts "this line, #{track_text}, is probably not a track"
				end
			end 
		end
		hash
	end

	def is_track?(line, threshold)
		if line.length > threshold ? false : true
			line.include? '-'
			true
		end
	end

	def split_artist_track(string)
		string = string.gsub("\n","")
		split_by = [" - ", " -- "]
		split_by.each do |split_text| 
			if string.include? split_text
				@artist, @track = string.split(split_text)
				return [@artist, @track]
			else
				@artist = 'Could not split artist track'
				@track = string
			end
		end
		[@artist, @track]
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