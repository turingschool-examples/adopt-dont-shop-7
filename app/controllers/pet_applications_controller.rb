class PetApplicationsController < ApplicationController
     def index
        @applications = Application.all
    end

    
    def show
        @application = Application.find(params[:id])
    end
    
private

    def pet_application_params
        params.permit(:id)
    end
end