class ApplicationPetsController < ApplicationController
    def index
        @application = Application.find(params[:artist_id])
        @pets = @application.pets
    end
end