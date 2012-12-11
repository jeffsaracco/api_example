TokenService::Application.routes.draw do
  devise_for :users

  get '/mu-b7a80520-38574f1d-8d74f9b9-cd358b57', :to => proc { |env| [200, {}, ["42"]] }

  resources :courses
  root :to=>"courses#index"

  namespace :api do
    namespace :v1  do
      resources :tokens, :only => [:create, :destroy]
    end
  end


end
