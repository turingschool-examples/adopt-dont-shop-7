class AdminsController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical_name
  end
end