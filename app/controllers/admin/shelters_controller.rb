class Admin::SheltersController < ApplicationController

    def index
        @admin_shelters = Shelter.reverse_alphabetical_order

        @shelters_with_pending_apps = Shelter.sort_by_pending
    end

end

