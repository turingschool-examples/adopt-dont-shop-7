class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_reverse_alphabetical
    @shelters_with_pending = Shelter.with_pending_apps
  end

  def show
    @shelter_name = Shelter.name_by_sql(params[:id])
    @shelter_city = Shelter.city_by_sql(params[:id])
    @shelter = Shelter.find(params[:id])
  end
end