class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_desc_alphabetical
  end
end
