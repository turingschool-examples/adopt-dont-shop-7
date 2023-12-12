class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.alphabetical_shelters_desc
    @shelters_with_pending_applications = Shelter.pending_applications
  end
end