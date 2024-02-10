class Admin::AdoptionApplicationsController < ApplicationController

    def show
        @app = AdoptionApplication.find(params[:id])
    end

end

