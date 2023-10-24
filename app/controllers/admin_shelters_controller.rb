class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical
    @test = Shelter.show_pending
  end

end