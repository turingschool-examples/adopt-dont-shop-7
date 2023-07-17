class AdminController < ApplicationController
  def index
    # @shelter = Shelter.find(params[:shelter_id])
    @shelters = Shelter.reverse_alpha
    @shelters_with_pending_applications = Shelter.pending_applications
    # require 'pry'; binding.pry
  end
  
  def show
    @application = Application.includes(:pets).find(params[:id])
  end
end