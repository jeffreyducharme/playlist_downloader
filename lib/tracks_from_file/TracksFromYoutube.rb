class TracksFromYoutube

attr_accessors :file 

def initialize(file)
	@file = file
end

def get_track_list_from_youtube_mix
	file = File.open(file)
	hash = {}
	track_num = 1
	file.each_line do |line|
	line = line.gsub("\n","")
	artist, track = line.split(' - ')
	artist = artist.gsub(/[0-9]+. /,'')
	pattern1 = / [0-9]+.[0-9]+/
	pattern2 = / [0-9]+.[0-9]+.[0-9]+/
	if track.match(pattern2)
		track = track.gsub(pattern2,'')
	elsif track.match(pattern1)
		track = track.gsub(pattern1,'')
	end
		hash[track_num] = {}
		hash[track_num][:artist] = artist
		hash[track_num][:track] = track
		track_num += 1
		hash
	end
end 

end 