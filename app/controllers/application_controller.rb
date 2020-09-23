class ApplicationController < ActionController::API
    def home
        render json: {success: true, data: 'hello from managex'}
    end
end



