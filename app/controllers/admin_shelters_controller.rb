class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name DESC;")
    @shelters_with_pending_applications = Shelter.joins(pets: { pet_applications: :application }).where(applications: { status: 'Pending' }).distinct
  end
end