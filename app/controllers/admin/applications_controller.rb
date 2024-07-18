class Admin::ApplicationsController < ApplicationsController
  def show
    @application = Application.find(params[:id])
    @pet_applications = PetApplication.associated_applications(@application.id)
    @pets = Pet.find_pet_by_name(params[:name.downcase]) if params[:name].present?
  end

  def update 
    @application = Application.find(params[:id])
    @pet_application = @application.pet_applications.find_by(params[:pet_id])
    if @pet_application.update(pet_app_status: params[:pet_app_status])
      redirect_to "/admin/applications/#{@application.id}"
    end
  end
end