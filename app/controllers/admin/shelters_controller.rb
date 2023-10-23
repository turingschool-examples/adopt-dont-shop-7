class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_reverse_alphabetical
    @shelters_with_pending = Shelter.with_pending_apps
  end

  private

  def shelter_params
    params.permit(:id, :name, :city, :foster_program, :rank)
  end
end