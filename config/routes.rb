Rails.application.routes.draw do
  namespace :v1 do
    # projects
    post "getProject", to: 'projects#get'
    post "getAlreadyPaid", to: 'projects#get_alredy_paid'
    #users
    post "login", to: 'users#login'
    post "signup", to: 'users#signup'
    post "logout", to: 'users#logout'
    post "me", to: 'users#me'
    post "test", to: 'users#test'
    post "getClientsForUser", to: 'users#get_clients'
    #orders
    post "createOrder", to: 'orders#create' 
    post "getOrders", to: 'orders#get'
    #apartments
    post "getApartments", to: 'apartments#get'
    #parkings
    post "getParkings", to: 'parkings#get'
    #payment_schedules
    post "createPaymentSchedule", to: 'payment_schedules#create'
    post "getPaymentSchedule", to: 'payment_schedules#get'
    #clients
    post "pay", to: 'clients#pay'
    post "clients", to: 'clients#get'
    #statistics
    post "statisticsMonthly", to: 'clients#show_payments_monthly'
    post "statisticsDaily", to: 'clients#show_payments_daily'
  end
  root "application#home"
end
