Rails.application.routes.draw do

  get 'snippets/repositories/:temporary_path/file/', to: "snippets#show", as: "snippet"
  get 'snippets/edit'
  get "repositories/", to: "repositories#index"
  get "repositories/new", to: "repositories#new", as: "new_repository"
  get "repositories/:temporary_path(/*current_path)", to: "repositories#show", as: "repository"
  get "repositories/edit/:temporary_path", to: "repositories#edit", as: "edit_repository"
  patch "repositories/", to: "repositories#update"
  delete "repositories/:temporary_path", to: "repositories#destroy"

  post "repositories/", to: "repositories#create"


  devise_for :accounts

  root to: "repositories#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

