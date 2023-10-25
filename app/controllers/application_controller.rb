class ApplicationController < ActionController::Base
  def welcome
  end

  def index
    @application = Application.all
  end
  
  private

    def error_message(errors)
      errors.full_messages.join(', ')
    end
end

