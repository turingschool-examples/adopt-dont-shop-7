class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_shelter_name
    @shelters_with_pending_applications = Shelter.with_pending_applications
  end
end