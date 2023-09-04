class ApplicationsController < ApplicationController
  def new
  end

  def show
    if params[:search].present?
      @searched_pets = Pet.search(params[:search])
    else
      @searched_pets = []
    end
    @application = PetsApplication.find(params[:id])
    @applicant = Applicant.retrieve_applicant(params[:id])
    # @pets = list_pets(@applicant)
    @pets = @applicant.pets
  end

  def create
    applicant = Applicant.new(applicant_params)
    if applicant.save
      application = PetsApplication.create!(applicant: applicant)
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(applicant.errors)}"
    end
  end

  def update
    application = PetsApplication.find(params[:id])
    update_empty_pet_app(application) if application.pet_id.nil?
    create_new_or_update_app(application)
    redirect_to "/applications/#{application.id}"
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
      all_apps = PetsApplication.where('applicant_id = ?', application.applicant_id)
      all_apps.each { |app| app.update(status: "Pending")}
    end
  end
end