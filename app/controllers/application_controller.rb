class ApplicationController < ActionController::Base
  def welcome
  end

  def index
    @applications = Application.all.order("name")
  end

  def show
    @application = Application.find(params[:id])
    # @pet = Pet.find(@application.pet_applications[0].pet_id)
  end

  def new
  end

  def create
    application = Application.new(application_params)
    application.save
    redirect_to "/applications/#{application.id}"
  end

  private

    def error_message(errors)
      errors.full_messages.join(', ')
    end
end

