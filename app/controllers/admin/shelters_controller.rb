class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.desc_alphabetical
    @pending_applications = Shelter.pending_apps
  end
end