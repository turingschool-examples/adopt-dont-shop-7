class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alpha_order
  end
end