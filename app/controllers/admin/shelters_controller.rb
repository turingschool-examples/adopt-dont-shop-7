class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_desc_alphabetical
    @shelters_pending = Shelter.pending_applications
  end
end
