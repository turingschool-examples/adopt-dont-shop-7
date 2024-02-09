class AdoptionApplicationController < ApplicationController
   def index
      @adotpion_apps = AdoptionApplication.all
   end

   def show
      @adoption_app = AdoptionApplication.find(params[:id])
   end

   def create
      adoption_app = AdoptionApplication.create(adoption_app_params)
      redirect_to "/applications/:id"
   end

   private
   def adoption_app_params
      params.permit(:name)
      params.permit(:street_address)
      params.permit(:city)
      params.permit(:state)
      params.permit(:zip_code)
      params.permit(:description)
   end
end