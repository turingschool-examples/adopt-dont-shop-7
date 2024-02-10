class Admin::AdoptionApplicationsController < ApplicationController

    def show
        @application = AdoptionApplication.find(params[:id])
    end

    def update
        @application = AdoptionApplication.find(params[:id])
        if @application.update(adoption_app_params)
            redirect_to "/admin/applications/#{@application.id}"
        else
            flash[:alert] = "Error: Could not approve or update"
            redirect_to "/admin/applications/#{@application.id}"
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

