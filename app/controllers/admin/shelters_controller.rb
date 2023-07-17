class Admin::SheltersController < ApplicationController
  
def index
  @shelters = Shelter.all
  @shelters = Shelter.reverse_alphabetical_order
end
end