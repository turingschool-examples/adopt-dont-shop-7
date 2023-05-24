class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name_reversed
    @shelters_with_pending_apps = Shelter.with_pending_apps
  end
end
