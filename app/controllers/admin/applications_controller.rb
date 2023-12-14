class Admin::ApplicationsController < ApplicationController
    def show 
        @app = Application.find(params[:id])
        @pet_apps = @app.pet_apps.includes(:pet)
    end

    def update
        @pet_app = @app.pet_apps.where(params[:pet_id])
    end
end