class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.desc_alphabetical
  end
end