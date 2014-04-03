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
      @soundcloud_uri = soundcloud_links(params[:artist])

      render :layout => "search"

      #echonest mood
      # @mood = params[:mood].gsub(' ', '+')
      # mood_search = HTTParty.get("http://developer.echonest.com/api/v4/song/search?api_key=8RYOJF4YSDMOQNMZW&format=json&mood=#{@mood}")["response"]["songs"]

      # #returns a new array of artist names and songs
      # mood_search.map do |song|
      #   [song["artist_name"], song["title"]]
      # end

      # #match @artist to song["artist_name"]
      # matches = []
      # if song["artist_name"].include?(@artist)
      #   matches << song["artist_name"]
      # end

  # track = client.get('/resolve', :url => track_url)
  end

  def background_picker
		backgrounds_array = ["http://www.zlok.net/blog/wp-content/uploads/under-construction-1.gif", "http://static.ragamuffinsoul.com/wp-content/uploads/2006/12/under_construction_animated.gif", "http://www.textfiles.com/underconstruction/SouthBeachDunes3911under-construction.gif", "http://i.stack.imgur.com/tM18j.gif", "http://i.stack.imgur.com/tM18j.gif"]
		background = backgrounds_array.sample
	end

  def soundcloud_links(search)
    begin
    results = SoundCloud.new(:client_id => "476bff90d2af3f775a10bf5bc1f82928").get('/search', :q => search)
    tracks = []
    results[:collection].each do |result|
      if result["kind"] == "track" && result["duration"] < 450000
        tracks << result
      end
    end

    final_results = []

    tracks.each do |track|
      if track["title"].downcase.include?(search.downcase) && track["title"].downcase.start_with?(search.downcase)
        final_results << track
      end
    end

    song = final_results.sample

    uri = song["uri"]
    uri = uri.gsub(/http:\/\//, '')

    return uri
     rescue
       "Soundcloud Link Not Available"
     end
  end

end


