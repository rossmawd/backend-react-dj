Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, :playlists, :likes, :listings, :dislikes, only: [:create, :show, :index, :edit, :destroy, :update]
      post "/login", to: "auth#create"
      get "/validate", to: "auth#validate"
      patch "/listing/:id", to: "listings#update_position"
    end
  end
end
