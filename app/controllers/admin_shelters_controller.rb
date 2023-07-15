class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("Select")
  end
end