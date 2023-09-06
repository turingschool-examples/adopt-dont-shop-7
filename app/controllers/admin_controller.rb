class AdminController < ApplicationController
  def index
    @shelters = Shelter.alphabetical_sort
    @shelters_pending = Shelter.pending_applications
  end
end
