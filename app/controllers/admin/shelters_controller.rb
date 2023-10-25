class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_reverse_alphabetical
    @shelters_with_pending = Shelter.with_pending_apps
  end
end