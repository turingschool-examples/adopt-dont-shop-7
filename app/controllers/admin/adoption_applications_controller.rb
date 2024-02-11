class Admin::AdoptionApplicationsController < ApplicationController

    def show
        @adoption_app = AdoptionApplication.find(params[:id])
    end

    def update
        @adoption_app = AdoptionApplication.find(params[:id])
        @adoption_app.approve_pet
        redirect_to "/admin/applications/#{@adoption_app.id}"
    end
    
end

private

def adoption_app_params
    params.permit(
        :name,
        :street_address,
        :city,
        :state,
        :zip_code,
        :description,
        :status)
        # when you use .merge directly on the result of params.permit, you're merging the additional parameters or default values into the hash returned by params.permit.
        .merge(status: "In Progress")
end

