Rails.application.routes.draw do
  devise_for :users, skip: "passwords"
  root "documents#index"
  post '/member_joined_channel' => 'member_joined_channel#callback', as: :member_joined_channel
  resources :documents
  resources :document_images, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
