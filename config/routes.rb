Rails.application.routes.draw do
  namespace :v1 do
    post "login", to: 'users#login'
    post "signup", to: 'users#signup'
    post "logout", to: 'users#logout'
  end
  root "application#home"
end
