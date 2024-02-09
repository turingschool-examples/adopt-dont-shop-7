class AdoptionApplicationsController < ApplicationController
   def show
      @adoption_app = AdoptionApplication.find(params[:id])
   end
end