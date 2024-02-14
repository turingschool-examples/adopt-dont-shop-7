class Admin::SheltersController < ApplicationController
    def index
        @shelters = Shelter.reverse_alphabetical_order
        @shelters_pending_applications = Shelter.pending_applications
    end
end