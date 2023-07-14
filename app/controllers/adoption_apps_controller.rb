class AdoptionAppsController < ApplicationController
  def show
    @adoption_app = AdoptionApp.find(params[:id])
  end
end