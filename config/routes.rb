Rails.application.routes.draw do
  namespace :v1 do
    #users
    post "login", to: 'users#login'
    post "signup", to: 'users#signup'
    post "logout", to: 'users#logout'
    post "me", to: 'users#me'
    post "test", to: 'users#test'
    #orders
    post "createOrder", to: 'orders#create' 
    post "getOrders", to: 'orders#get'
    #apartments
    post "getApartments", to: 'apartments#get'
    #parkings
    post "getParkings", to: 'parkings#get'
    #projects
    post "getProjects", to: 'projects#get'
    #payment_schedules
    post "createPaymentSchedule", to: 'payment_schedules#create'
    post "getPaymentSchedule", to: 'payment_schedules#get'
    #clients
    post "pay", to: 'clients#pay'
    post "clients", to: 'clients#get'
  end
  root "application#home"
end
