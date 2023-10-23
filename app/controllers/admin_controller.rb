class AdminController < ApplicationController
  def index
    @shelters = Shelter.order_by_name_reverse
    @pendingshelters = Shelter.shelters_apps_in_progress
  end


end