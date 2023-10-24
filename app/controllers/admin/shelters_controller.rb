class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.reverse_alphabetical_order
    @shelters_w_apps = Shelter.pending_apps
  end
  
end