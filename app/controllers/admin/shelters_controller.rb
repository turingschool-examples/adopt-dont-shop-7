class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical
    @shelters_pending_apps = Shelter.has_pending_app
  end
end