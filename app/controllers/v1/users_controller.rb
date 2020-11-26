class V1::UsersController < ApplicationController
    before_action :authorized, except: [:login]
    
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

    def get_sales_info
        apartments = @user.orders.filter{|o| o.apartments.count != 0 && o.project_id == params[:project_id].to_i}
        parkings = @user.orders.filter{|o| o.parkings.count != 0 && o.project_id == params[:project_id].to_i}
        apartment_space = apartments.map{|o| o.apartments[0].space}
        parking_space = parkings.map{|o| o.parkings[0].space}
        full_space_arr = apartment_space + parking_space
        full_space = full_space_arr.reduce(0){|a, e| a + e}

        render json: {success: true, parkings: parkings.count, apartments: apartments.count, full_space: full_space}
    end

    private

    def user_params
        params.permit(:password, :username, :email, :project_id)
    end

end
