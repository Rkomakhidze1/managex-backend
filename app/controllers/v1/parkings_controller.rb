class V1::ParkingsController < ApplicationController
    before_action :authorized

    def get
        project = Project.find parking_params[:project_id]
        parkings = project.parkings
        render json: {success: true, parkings: parkings}, status: :ok
    end

    private 

    def parking_params
        params.permit(:project_id)
    end
end
