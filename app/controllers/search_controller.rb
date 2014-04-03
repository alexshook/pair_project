class SearchController < ApplicationController

  def index
  	@background = background_picker
    render :layout => "application"
  end

  def show
    @artist = params[:artist].gsub(' ', '+')
    artist_search = HTTParty.get("http://api.giphy.com/v1/gifs/search?q=#{@artist}&api_key=dc6zaTOxFJmzC")
    @gif_url = artist_search["data"].sample["images"]["original"]["url"]

    @artist_pretty = @artist.gsub('+', ' ').titleize
    @test = soundcloud_links(@artist)
    render :layout => "search"

    #echonest mood
    @mood = params[:mood].gsub(' ', '+')
    #errors on type = mood
    mood_search = HTTParty.get("http://developer.echonest.com/api/v4/artist/list_terms?api_key=8RYOJF4YSDMOQNMZW&format=json&name=#{@artist}&type=mood")

# track = client.get('/resolve', :url => track_url)
  end

  def background_picker
		backgrounds_array = ["http://www.zlok.net/blog/wp-content/uploads/under-construction-1.gif", "http://static.ragamuffinsoul.com/wp-content/uploads/2006/12/under_construction_animated.gif", "http://www.textfiles.com/underconstruction/SouthBeachDunes3911under-construction.gif", "http://i.stack.imgur.com/tM18j.gif", "http://i.stack.imgur.com/tM18j.gif"]
		background = backgrounds_array.sample
	end

  def soundcloud_links(search)
    # begin
    tracks = SoundCloud.new(:client_id => "476bff90d2af3f775a10bf5bc1f82928").get('/search', :q => search)
    results = tracks[:collection][0..30]
    # results.select{ |e| e["duration"] < 450000 }

    final_results = []
    results.each do |song|
      if song["title"].include?(search)
        final_results << song
      end
    end

    # # song = final_results.sample

    # uri = song["uri"]

    return final_results
     # rescue
     #   "Soundcloud Link Not Available"
     # end
  end

end


