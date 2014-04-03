class SearchController < ApplicationController

  def index
  	@background = background_picker



  end
  # HTTParty.get('http://api.giphy.com/v1/gifs/search?q=snoop+dog&api_key=dc6zaTOxFJmzC')


  def background_picker
		backgrounds_array = ["http://www.zlok.net/blog/wp-content/uploads/under-construction-1.gif", "http://static.ragamuffinsoul.com/wp-content/uploads/2006/12/under_construction_animated.gif", "http://www.textfiles.com/underconstruction/SouthBeachDunes3911under-construction.gif", "http://i.stack.imgur.com/tM18j.gif", "http://i.stack.imgur.com/tM18j.gif"]
		background = backgrounds_array.sample
	end

end


