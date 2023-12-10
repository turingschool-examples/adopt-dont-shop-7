class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = @application.pet_search(params[:pet_name])
  end

  def new 

  end

  def create 
    application = Application.new({
      name: params[:name],
      street: params[:street],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      descr: params[:good_owner]
    })

    if application.save
      redirect_to "/applications/#{application.id}"
    else 
      flash[:alert] = "Application not created: Required information missing."

      redirect_to "/applications/new"
    end
  end

  def update
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:pet_id])

    @pet_application = PetApplication.create!({
      pet_id: @pet.id,
      application_id: @application.id
    })

    @pets = @application.pets
  
    redirect_to "/applications/#{@application.id}"
  end
end