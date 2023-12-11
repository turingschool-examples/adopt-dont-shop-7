class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.alphabetical_shelters_desc
  end
end