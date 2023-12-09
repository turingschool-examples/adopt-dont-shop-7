class Admin::ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    
    application = Application.find(params[:app_id])
    pet_application = PetApplication.pet_app(params[:pet_id], params[:app_id])
    
    if pet_application.status == "In Progress" || pet_application.status == "Pending"
      if
        pet_application.update!(status: "Approved")
        redirect_to "/admin/applications/#{application.id}"
        flash[:notice] = "#{pet.name}'s application has been updated"
      end
    else
      redirect_to "/admin/applications/#{pet_app.id}"
      flash[:alert] = "Error: There was a problem and your updates did not take effect"
    end
  end

end






