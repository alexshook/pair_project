class SearchController < ApplicationController

  def index
  	@background = background_picker
  end

  def show
    @artist = params[:artist].gsub(' ', '+')
    artist_search = HTTParty.get("http://api.giphy.com/v1/gifs/search?q=#{@artist}&api_key=dc6zaTOxFJmzC")
    @gif_url = artist_search["data"].sample["images"]["original"]["url"]
    @artist_pretty = @artist.gsub('+', ' ')
  end

  def background_picker
		backgrounds_array = ["http://www.zlok.net/blog/wp-content/uploads/under-construction-1.gif", "http://static.ragamuffinsoul.com/wp-content/uploads/2006/12/under_construction_animated.gif", "http://www.textfiles.com/underconstruction/SouthBeachDunes3911under-construction.gif", "http://i.stack.imgur.com/tM18j.gif", "http://i.stack.imgur.com/tM18j.gif"]
		background = backgrounds_array.sample
	end

  def soundcloud_links(search)
    begin
    tracks = []
    tracks << SoundCloud.new(:client_id => "476bff90d2af3f775a10bf5bc1f82928").get('/search', :q => search)
    results = tracks[0][:collection][1..30]
    #binding.pry
    results.select{ |e| e["duration"] < 450000 }



    return uri
     rescue
       "Soundcloud Link Not Available"
     end
  end

end


