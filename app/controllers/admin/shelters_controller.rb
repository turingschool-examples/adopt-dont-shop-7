class Admin::SheltersController < ApplicationController
  
def index
  @shelters_all = Shelter.all
  @shelters = Shelter.reverse_alphabetical_order
end
end