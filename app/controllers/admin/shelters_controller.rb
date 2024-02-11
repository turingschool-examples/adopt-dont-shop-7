class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alpha
    @shel_pends = Shelter.only_pending_apps
  end
end