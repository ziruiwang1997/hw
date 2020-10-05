Rottenpotatoes::Application.routes.draw do
  resources :movies do
    get "with_same_director"
  end
  # get '/movies/with_same_director/:id', to: 'movies#with_same_director', as: 'movies_with_same_director'
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
