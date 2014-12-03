class SearchController < ApplicationController

  def index
  	@background = background_picker
    render :layout => "application"
  end

  def show
    @artist = params[:artist].gsub(' ', '+')
    if @artist.length < 1
      redirect_to :back
    else
      artist_search = HTTParty.get("http://api.giphy.com/v1/gifs/search?q=#{@artist}&api_key=dc6zaTOxFJmzC")

      #### this if should eventually be replaced by hall_of_fame methode
      if artist_search["data"].count == 0
        @gif_url = 'http://media0.giphy.com/media/CF2cg4YbWsYQo/giphy.gif'
        @artist_pretty ='nope... so DIPLO!'
        @soundcloud_uri = 'api.soundcloud.com/tracks/83308020'
      else
        @gif_url = artist_search["data"].sample["images"]["original"]["url"]
        @artist_pretty = @artist.gsub('+', ' ').titleize
        @soundcloud_uri = soundcloud_links(params[:artist])
      end
    end
    render :layout => "search"
  end

  def background_picker
		backgrounds_array = ["http://www.zlok.net/blog/wp-content/uploads/under-construction-1.gif", "http://static.ragamuffinsoul.com/wp-content/uploads/2006/12/under_construction_animated.gif", "http://www.textfiles.com/underconstruction/SouthBeachDunes3911under-construction.gif", "http://i.stack.imgur.com/tM18j.gif", "http://i.stack.imgur.com/tM18j.gif"]
		background = backgrounds_array.sample
	end

  def soundcloud_links(search)
    begin
    results = SoundCloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID']).get('/search', :q => search)
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
    no_cover = []
    final_results.each do |track|
      if !track["title"].downcase.include?("cover")
        no_cover << track
      end
    end

    song = no_cover.sample
    uri = song["uri"]
    uri = uri.gsub(/http:\/\//, '')
    return uri
    rescue
      "Soundcloud Link Not Available"
    end
  end
end
