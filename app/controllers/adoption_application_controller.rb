class AdoptionApplicationController < ApplicationController
   def show
      @adoption_app = AdoptionApplication.find(params[:id])
   end
end