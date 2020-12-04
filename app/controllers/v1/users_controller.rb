class V1::UsersController < ApplicationController
    before_action :authorized, except: [:login]
    
    def login
        user = User.find_by! username: login_params[:username]
        team = Team.find_by! id: user.team_id
        projects = team.projects.map{|p| {id: p.id, name: p.name}}
        users = team.users.filter{|u| u.id != user.id}

        if user.authenticate login_params[:password]
            token = encode_token({user_id: user.id})
            user.tokens.push token
            if user.save
                render json: {success: true, user: user, projects: projects, users: users, token: token}, status: :ok
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
        team = Team.find_by! id: @user.team_id
        projects = team.projects.map{|p| {id: p.id, name: p.name}}
        users = team.users.filter{|u| u.id != @user.id}
        render json: {success: true, user: @user, projects: projects, users: users}, status: :ok
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

    def update_profile
        team = Team.find_by! id: @user.team_id
        projects = team.projects.map{|p| {id: p.id, name: p.name}}
        users = team.users.filter{|u| u.id != @user.id}

        @user.email = user_params[:email]
        @user.username = user_params[:username]
        if user_params[:password]
            @user.password = user_params[:password]
        end

        if @user.save
            render json:{success: true, user: @user, projects: projects, users: users}, status: :ok
        else
            render json:{success:false, message: err_msg(@user)}, status: :bad_request
        end
    end 

    def change_role
        if @user.role != 'admin'
          return render json:{success: false, message: "not allowed"}, status: :forbidden
        end
        target_user = User.find_by! username: user_params[:username]
        target_user.role = user_params[:role]

        if target_user.save
            render json:{success: true, message: "changes saved"}, status: :ok
        else
            render json: {success: false, message: err_msg(target_user)}
        end

    end


    private

    def login_params
        params.permit(:username, :password)
    end

    def user_params
        params.permit(:username, :email, :password, :project_id, :role)
    end

end
