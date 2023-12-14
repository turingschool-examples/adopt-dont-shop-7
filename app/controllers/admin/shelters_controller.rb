class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_sort_by_name
    @apps = Shelter.pending_apps
  end
end