Rails.application.routes.draw do
  namespace :v1 do
    post "login", to: 'users#login'
    post 'users/signup'
    post 'users/logout'
  end
  root "application#home"
end
