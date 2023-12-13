class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_sort_by_name
  end
end