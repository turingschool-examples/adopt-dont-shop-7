class Admin::SheltersController < ApplicationController
  def index
    @shelters_all = Shelter.all
    @shelters = Shelter.reverse_alphabetical_order
    @shelters_with_pending_apps = Shelter.pending_applications
   @applications = Application.pending_shelters_application
  
  end
end