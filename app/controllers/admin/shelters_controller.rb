class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_reverse_alphabetically
    @shelters_pending = Shelter.pending_applications
  end

  def show
    @shelter = Shelter.find(params[:id])
  end
end
