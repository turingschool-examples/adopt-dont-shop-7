class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def update
    
    @application = Application.find(params[:id])
    
    @application_pet = ApplicationPet.find_by(pet_id: params[:pet_id], application_id: params[:id])
   
      if params[:commit].include?("Approve")
        # @application_pet.update(pet_adoptable: "approve")
        @application_pet.approve
      redirect_to "/admin/applications/#{@application.id}"
    elsif params[:commit].include?("Reject")
      # @application_pet.update(pet_adoptable: "reject")
      @application_pet.reject
      redirect_to "/admin/applications/#{@application.id}"

    end
  end
end



 
  