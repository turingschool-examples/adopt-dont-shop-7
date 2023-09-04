class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.all.reverse_alphabetical
    @shelters_with_applicants = Shelter.with_applicants
  end
end