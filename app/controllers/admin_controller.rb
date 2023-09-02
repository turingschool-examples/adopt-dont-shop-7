class AdminController < ActionController::Base
  def shelters_index
    @shelters = Shelter.order_by_name_alphabetical
    @pending_apps = Shelter.with_pending_applications
  end

  def show
    @application = PetsApplication.find(params[:id])
    @pets = Pet.pets_with_app_status(@application)
  end

  def approve_reject
    @application = PetsApplication.where('pet_id = ?', params[:pet_id])
    @application.update(status: params[:status])
    redirect_to "/admin/applications/#{params[:id]}"
  end
end