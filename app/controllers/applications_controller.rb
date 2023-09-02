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
    applicant = Applicant.new({
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description],
    })

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
    if application.pet_id == nil
      application.update ({
        pet_id: params[:pet]
      })
    else
      PetsApplication.create!(applicant_id: application.applicant_id, pet_id: params[:pet])
      redirect_to "/applications/#{application.applicant_id}"
    end
  end

  private 

  def list_pets(applicant)
    pets = []
    applications = PetsApplication.where('applicant_id = ?', @applicant.id)
    applications.each do |application|
      if !application.pet_id.nil?
        pets << Pet.find(application.pet_id)
      end
    end
    pets
  end
  
end