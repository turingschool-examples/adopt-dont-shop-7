
  class Admin::SheltersController < ApplicationController
    def index
      @shelters = Shelter.reverse_alphabetical
      @pending_applications = Shelter.pending_applications
      # require 'pry';binding.pry
    end 

  end

