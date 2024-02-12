class AdminSheltersController < ApplicationController

  def index
    @shelters = Shelter.order_by_reverse_alpha
    @shelters_p_a = Shelter.find_pending_applications
  end
end