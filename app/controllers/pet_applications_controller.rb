class PetApplicationsController < ApplicationController
  def create
    PetApplication.create(application_id: params[:id], pet_id: params[:adopt])

    redirect_to "/applications/#{params[:id]}"
  end

  def update
    pet_app = PetApplication.where(application_id: params[:id], pet_id: params[:pet_id])
    pet_app.update!(status: !ActiveRecord::Type::Boolean.new.cast(params[:approve]))

    redirect_to "/admin/applications/#{params[:id]}"
  end
end
