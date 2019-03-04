Rails.application.routes.draw do
  get "/", to: "welcome#home", as: :root
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :ideas

  resources :ideas do
    resources :reviews, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :update, :edit]

  resource :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
end
