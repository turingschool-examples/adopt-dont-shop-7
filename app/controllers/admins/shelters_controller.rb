class Admins::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_reverse_alphabetically
  end
end
