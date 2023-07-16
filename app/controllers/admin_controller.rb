class AdminController < ApplicationController
  def index
    @shelters = Shelter.reverse_alpha
    @shelters_with_pending_applications = Shelter.pending_applications
    # require 'pry'; binding.pry
  end
  
  # def show
  #   @application = Application.find(params[:application_id])
  #   @shelter = Shelter.find(params[:shelter_id])
  
  #   @shelters.applications << @application

  #   redirect "admin/shelters"
  # end
end