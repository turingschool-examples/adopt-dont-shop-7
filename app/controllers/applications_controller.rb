class ApplicationsController < ApplicationController
    def show
        @application = Application.find(params[:id])
        
        @pets = Pet.search(params[:search])
        
        if params[:added_pet].present? 
            pet_id = params[:added_pet]
            @application.add_pet_to_application(pet_id)
        end
    end
    
    def new 
    end
    
    def create
        application = Application.new(application_params)

        if application.save
            redirect_to "/applications/#{application.id}"
        else
            redirect_to "/applications/new"
            flash[:alert] = "Error: #{error_message(application.errors)}"
        end
    end
    
    private
    def application_params
        params.permit(:id, :name, :street_address, :city, :state, :zip_code, :description, :status)
    end
end