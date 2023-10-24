class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical
    @shelters_with_apps = Shelter.show_pending
  end

end