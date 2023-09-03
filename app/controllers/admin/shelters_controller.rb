
  class Admin::SheltersController < ApplicationController
    def index
      @shelters = Shelter.all
      # require 'pry';binding.pry
    end 
  end

