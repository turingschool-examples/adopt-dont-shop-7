class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_ordered
  end
end
