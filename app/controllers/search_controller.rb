class SearchController < ApplicationController
  def index

  end

  def show
    @artist = params[:artist]
    @artist.gsub(' ', '+')
    artist_search = HTTParty.get("http://api.giphy.com/v1/gifs/search?q=#{@artist}&api_key=dc6zaTOxFJmzC")
    @gif_url = artist_search["data"][0]["images"]["original"]["url"]
  end

  # HTTParty.get('http://api.giphy.com/v1/gifs/search?q=snoop+dog&api_key=dc6zaTOxFJmzC')
end
