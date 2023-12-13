class ApplicationsController < ApplicationController
  def index

  end

  def new

  end

  def create
    @application = Application.new(application_params)
    @application.set_status_in_progress
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:notice] = "Error: Application not created: Required information missing."
      redirect_to new_application_path
    end
  end

  def edit

  end

  def update
    application = Application.find(params[:id])
    if params[:good_owner_comments].present?
      application.update(
        good_owner_comments: [params[:good_owner_comments]],
        status: "Pending"
      )
    end

    redirect_to show_application_path
  end

  def show
    @application = Application.find(params[:id])
    if params[:pet_name].present?
        @pets = Pet.search(params[:pet_name])
    end
  end

  def destroy

  end

  private
  def application_params
    params.permit(
      :name,
      :street_address,
      :city,
      :state,
      :zipcode,
      :description,
      :good_owner_comments)
  end
end
