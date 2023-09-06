class AdminController < ApplicationController
  def index
    @shelters = Shelter.alphabetical_sort
    @shelters_pending = Shelter.pending_applications
  end

  def show
    @application = Application.find(params[:id])
  end
end
