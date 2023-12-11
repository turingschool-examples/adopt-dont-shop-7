class Admin::ApplicationsController < Admin::ApplicationsController

  def show
    @application = Admin.application(params[:id])
    if params[:filter].present?
      pet_application = Admin.approve_or_deny_application_pet(params[:pet_id], params[:id], params[:filter])
    end
  end
end
