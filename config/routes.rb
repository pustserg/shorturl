Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/urls', to: 'urls#create'
  get '/urls/:short_url', to: 'urls#show'
  get 'urls/:short_url/stats', to: 'urls#stats'
end
