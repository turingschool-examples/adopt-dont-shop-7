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
      flash[:alert] = "Error: All fields are required."
      redirect_to new_application_path
      # Is this the correct location? Or should we move this error message text to application_controller.rb or another file?
      ## So I looked it up, I think this is where it goes, but I don't know why it automatically renders and we don't get to choose where to render it in the view... kind of annoying that it's at the top of the page, maybe we can ask in a study hall or something. For now, it works?
    end
  end

  def edit

  end

  def update

  end

  def show
    @application = Application.find(params[:id])
  end

  def destroy

  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description)
  end
end
