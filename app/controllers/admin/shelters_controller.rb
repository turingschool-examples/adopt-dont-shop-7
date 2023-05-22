class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.admin_sort_reverse_alpha
  end
end