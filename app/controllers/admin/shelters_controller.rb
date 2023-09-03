
  class Admin::SheltersController < ApplicationController
    def index
      @shelters = Shelter.reverse_alphabetical
      # require 'pry';binding.pry
    end 
  end

