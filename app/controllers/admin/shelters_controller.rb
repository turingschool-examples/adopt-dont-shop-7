class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_reverse_name
  end
end