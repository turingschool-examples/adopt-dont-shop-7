class Admin::AdoptionApplicationsController < ApplicationController

    def show
        @application = AdoptionApplication.find(params[:id])
    end

    def update
        @application = AdoptionApplication.find(params[:id])
        if update(adoption_app_params)
            approve_pet
            true
        else
            false
            flash[:alert] = "Error: Could not approve or update"
        end
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

