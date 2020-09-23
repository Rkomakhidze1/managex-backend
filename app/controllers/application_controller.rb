class ApplicationController < ActionController::API
    def home
        render html: 'hello from managex'
    end
end



