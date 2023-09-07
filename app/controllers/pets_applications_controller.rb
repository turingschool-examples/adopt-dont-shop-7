class PetsApplicationsController < ApplicationController
  def new
  end

  def show
    @searched_pets = pet_search
    @application = PetsApplication.find(params[:id])
    @applicant = Applicant.retrieve_applicant(params[:id])
    @pets = @applicant.pets
    @status = PetsApplication.check_app_status(@applicant)
  end

  def create
    applicant = Applicant.new(applicant_params)
    if applicant.save
      application = PetsApplication.create!(applicant: applicant)
      redirect_to "/pets_applications/#{application.id}"
    else
      redirect_to "/pets_applications/new"
      flash[:alert] = "Error: #{error_message(applicant.errors)}"
    end
  end

  def update
    application = PetsApplication.find(params[:id])
    application.pet_id.nil? ? update_empty_pet_app(application) : create_new_or_update_app(application)
    applicant = Applicant.find(application.applicant_id)
    applicant.update(description: params[:description])
    redirect_to "/pets_applications/#{application.id}"
  end

  private 

  def applicant_params
    params.permit(:id, :name, :street_address, :city, :state, :zip_code, :description)
  end

  def update_empty_pet_app(application)
    application.update ({
        pet_id: params[:pet]
      })
  end

  def create_new_or_update_app(application)
    if params[:status].nil?
      PetsApplication.create!(applicant_id: application.applicant_id, pet_id: params[:pet])
    else
      all_apps = PetsApplication.all_apps_for_applicant(application)
      all_apps.each { |app| app.update(status: "Pending")}
    end
  end

  def pet_search
    if params[:search].present?
      @searched_pets = Pet.search(params[:search])
    else
      @searched_pets = []
    end
  end
end