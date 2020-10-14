Rails.application.routes.draw do
  namespace :v1 do
    #users
    post "login", to: 'users#login'
    post "signup", to: 'users#signup'
    post "logout", to: 'users#logout'
    #orders
    post "orders", to: 'orders#create'
    get "orders", to: 'orders#get'
    #apartments
    post "getApartments", to: 'apartments#get'
  end
  root "application#home"
end
