class ApplicationPetsController < ApplicationController
  def index
    @shelters = Shelter.order_by_reverse_alphabetical
    @shelters_pending = Shelter.have_pending_applications
  end
end