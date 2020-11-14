class V1::UsersController < ApplicationController
    before_action :authorized, only: [:logout, :me]
    
    def login
        user = User.find_by! username: user_params[:username]
        if user.authenticate user_params[:password]
            token = encode_token({user_id: user.id})
            user.tokens.push token
            if user.save
                render json: {success: true, user: user, token: token}, status: :ok
            else
                
            end
        else
            render json: {success: false, message: "failed to login"}, status: :bad_request
        end
    end


    def logout
        @user.tokens = []
        @user.save
        render json: {success: true, message: "logged out successfully"}, status: :ok
    end

    def me
        render json: {success: true, user: @user}, status: :ok
    end

    def test
        render json: {success: true, user: "test passed!"}, status: :ok
    end

    private

    def user_params
        params.permit(:password, :username, :email)
    end
    
end
