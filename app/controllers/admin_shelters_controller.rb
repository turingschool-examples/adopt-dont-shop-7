class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name_reversed
    @shelters_with_pending_apps = Shelter.with_pending_apps
  end

  private

  def shelter_params
    params.permit(:id, :name, :address, :city, :state, :zip)
  end
end