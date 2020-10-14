class V1::ApartmentsController < ApplicationController
    # before_action :authorized

    def get
        project = Project.find apartment_params[:project_id]
        apartments = project.apartments
        render json: {success: true, apartments: apartments}, status: :ok
    end

    private 

    def apartment_params
        params.permit(:project_id)
    end
end
