class ApplicationController < ActionController::Base
  def welcome
  end

  def show
    @applications = Application.all
  end

  def new
  end

  def create
    Application.create!(app_params)
    redirect_to "/application/show"
  end
  private

  def app_params
    params.permit(:applicant, :address, :description, :status)
  end
    def error_message(errors)
      errors.full_messages.join(', ')
    end
end

