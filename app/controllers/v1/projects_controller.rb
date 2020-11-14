class V1::ProjectsController < ApplicationController
    # before_action :authorized

    def get
        project = Project.find project_params[:project_id]
        render json: {success: true, project: project}, status: :ok
    end

    def get_alredy_paid
        project = Project.find project_params[:project_id]
        orders = project.orders
        clients = orders.map{|o| Client.find o.client_id}
        alredy_paid = clients.map {|c| c.already_paid}
        sum = alredy_paid.reduce(0) {|a, p| a + p} 
        render json: {success: true, already_paid: sum}, status: :ok
    end

    private 

    def project_params
        params.permit(:project_id)
    end
end
