class Admin::SheltersController < ApplicationController

    def index
        @admin_shelters = Shelter.all.reverse_alphabetical_order

        @shelter_with_pending_apps = Shelter.all.sort_by_pending
    end
end

