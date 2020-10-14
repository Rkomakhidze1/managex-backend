class V1::ProjectsController < ApplicationController
    # before_action :authorized

    def get
        projects = Project.find project_params[:project_id]
        render json: {success: true, projects: projects}, status: :ok
    end

    private 

    def project_params
        params.permit(:project_id)
    end
end
