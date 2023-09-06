class AdminController < ApplicationController
  def index
    @shelters = Shelter.alphabetical_sort
  end
end