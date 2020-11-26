class V1::ProjectsController < ApplicationController
    before_action :authorized

    def get
        project = Project.find project_params[:project_id]
        project_count = Project.all.count
        apartments_sold  = project.apartments.filter{|a| a.reserved}.count
        parkings_sold  = project.parkings.filter{|p| p.reserved}.count

        response = 
            {
                project: project,
                project_count: project_count, 
                apartments_sold: apartments_sold, 
                parkings_sold: parkings_sold
            }

        render json: {success: true, data: response}, status: :ok
    end

    private 

    def project_params
        params.permit(:project_id)
    end
end
