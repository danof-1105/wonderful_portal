Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: {
    confirmations: "users/confirmations"
  }
  root "documents#index"
  post '/member_joined_channel' => 'member_joined_channel#callback', as: :member_joined_channel
  resources :documents
  resources :document_images, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
