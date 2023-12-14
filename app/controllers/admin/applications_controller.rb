class Admin::ApplicationsController < ApplicationController
    def show 
        @app = Application.find(params[:id])
        @pet_apps = @app.pet_apps.includes(:pet)
    end
end