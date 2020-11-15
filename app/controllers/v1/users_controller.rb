class V1::UsersController < ApplicationController
    before_action :authorized, only: [:logout, :me, :get_clients]
    
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

    def get_clients
        all_clients = @user.orders.map {|o| Client.find o.client_id}
        clients = all_clients.filter {|c| c.project_id == user_params[:project_id]}
        render json: {success: true, clients: clients }, status: :ok
    end

    private

    def user_params
        params.permit(:password, :username, :email, :project_id)
    end

end
