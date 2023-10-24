class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name DESC;")
    require 'pry'; binding.pry
    @shelters_with_pending_applications
  end
end