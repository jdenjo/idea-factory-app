Rails.application.routes.draw do
  get "/", to: "welcome#home", as: :root
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :ideas
end
