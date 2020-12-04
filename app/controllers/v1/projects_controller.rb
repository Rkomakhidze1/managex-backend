class V1::ProjectsController < ApplicationController
    before_action :authorized

    def get
        project = Project.find project_params[:project_id]
        project_count = Project.all.count
        apartments_sold  = project.apartments.filter{|a| a.reserved}
        parkings_sold  = project.parkings.filter{|p| p.reserved}

        apartments_space = apartments_sold.reduce(0) {|a, e| a + e.space}
        parkings_space = parkings_sold.reduce(0) {|a, e| a + e.space}
        full_space_sold = apartments_space + parkings_space
        response = 
            {
                project: project,
                project_count: project_count, 
                apartments_sold: apartments_sold.count, 
                parkings_sold: parkings_sold.count,
                space_sold: full_space_sold
            }

        render json: {success: true, data: response}, status: :ok
    end

    private 

    def project_params
        params.permit(:project_id)
    end
end
