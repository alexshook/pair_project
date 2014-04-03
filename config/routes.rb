PairProject::Application.routes.draw do
  root to: 'search#index'

  get '/search' => 'search#show'



end
