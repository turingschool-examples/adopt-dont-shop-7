class Admin::SheltersController < ApplicationController

    def index
        @admin_shelters = Shelter.all.reverse_alphabetical_order
    end
end

