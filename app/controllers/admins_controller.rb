class AdminsController < ActionController::Base
  def index
    @shelters = Admin.shelters
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def show
    @application = Admin.application(params[:id])
    if params[:filter].present?
      pet_application = Admin.approve_or_deny_application_pet(params[:pet_id], params[:id], params[:filter])
    end
  end

  def destroy

  end
end
