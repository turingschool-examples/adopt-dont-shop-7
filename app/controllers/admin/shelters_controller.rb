class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alpha
    @shel_pends = Shelter.only_pending_apps
  end

  def show
    @shelter = Shelter.find(params[:id])
  end
end