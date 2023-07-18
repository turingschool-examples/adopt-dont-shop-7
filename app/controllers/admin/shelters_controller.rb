class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_shelter_name
  end
end