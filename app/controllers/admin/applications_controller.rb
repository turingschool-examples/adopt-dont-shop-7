class Admin::ApplicationsController < ApplicationController
    def show
      @application = Application.find(params[:id])
      @pets = @application.pets
    end
  
    def update
      @application = Application.find(params[:id])
      @pet = Pet.find(params[:pet_id])
      if params[:commit] == "Approve #{@pet.name} for Adoption"
        @pet.update({status: "Approved"})
        @pet.save
      end
      redirect_to "/admin/applications/#{@application.id}"
    end
  end