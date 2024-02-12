class ApplicationsController < ApplicationController
    
    def show
        # require 'pry'; binding.pry
        @application = Application.find(params[:id])
        # require 'pry'; binding.pry

        if params[:pet_name].present?
            @pets = Pet.search(params[:pet_name])
        end


         
    end

    def update
        @application = Application.find(params[:id])

        if params[:why_i_would_make_a_good_owner].present?
            @application.update(status: "Pending")
        end

        redirect_to "/applications/#{@application.id}"


    end

    def new 
    end

    def create 
        application = Application.new(application_params)
        if application.save
            redirect_to "/applications/#{application.id}"
        else
            flash[:alert] = 'All fields must be filled in'
            redirect_to "/applications/new"
        end

    end

    private 

    def application_params
        params.permit(:name,:street_address,:city, :state, :zip_code, :description)
    end
end