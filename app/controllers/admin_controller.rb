class AdminController < ActionController::Base
  def shelters_index
    @shelters = Shelter.order_by_name_alphabetical
    @pending_apps = Shelter.with_pending_applications
  end

  def show
    @application = PetsApplication.find(params[:id])
    @applicant = Applicant.find(@application.applicant_id)
    @pets = Pet.pets_with_app_status_by_sql(@application)
  end

  def approve_reject
    @application = PetsApplication.find_application_for_approve(params[:pet_id], params[:applicant_id])
    @application.first.update(status: params[:status])
    redirect_to "/admin/applications/#{params[:id]}"
  end
end