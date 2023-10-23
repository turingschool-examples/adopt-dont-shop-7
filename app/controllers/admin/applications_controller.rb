class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @approved_pets = []

    if request.post?
      pet = Pet.find(params[:pet_id])
      @approved_pets << pet

      flash[:notice] = "Pet approved!"
      redirect_to admin_application_path(@application)
    end
  end
end
