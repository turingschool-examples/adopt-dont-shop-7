class ApplicationController < ActionController::Base
  def welcome
  end

  def show
    @application = Application.find(params[:id])
    # @pet = Pet.find(@application.pet_applications[0].pet_id)
  end

  private

    def error_message(errors)
      errors.full_messages.join(', ')
    end
end

