class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.admin_sort_reverse_alpha
    @pending_shelters = Shelter.with_pending_applications
  end
end