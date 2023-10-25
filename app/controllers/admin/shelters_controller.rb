class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_abc
    @shelters_pending_applications = Shelter.pending_applications
  end

  def show
    @shelter = Shelter.find(params[:id])
  end
end
