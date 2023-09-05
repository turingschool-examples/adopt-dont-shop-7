class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.shelters_order
  end

end