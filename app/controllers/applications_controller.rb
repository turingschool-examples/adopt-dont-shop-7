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
    elsif params[:status].nil?
      PetsApplication.create!(applicant_id: application.applicant_id, pet_id: params[:pet])
    else
      all_apps = PetsApplication.where('applicant_id = ?', application.applicant_id)
      all_apps.each { |app| app.update(status: "Pending")}
    end
    redirect_to "/applications/#{application.id}"
  end

  private 
end