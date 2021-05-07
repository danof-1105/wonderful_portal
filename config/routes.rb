Rails.application.routes.draw do
  get "document_images/image"
  devise_for :users, skip: "passwords"
  resources :documents
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
