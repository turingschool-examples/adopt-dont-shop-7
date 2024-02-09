class AdoptionApplicationController < ApplicationController
   def index
      @adotpion_apps = AdoptionApplication.all
   end

   def show
      @adoption_app = AdoptionApplication.find(params[:id])
   end

   def new
   end

   def create
      adoption_app = AdoptionApplication.create(adoption_app_params)
      redirect_to "/applications/#{adoption_app.id}"
   end

   private
   def adoption_app_params
      params.permit(:name)
      params.permit(:street_address)
      params.permit(:city)
      params.permit(:state)
      params.permit(:zip_code)
      params.permit(:description)
      params.permit(:status)
      # when you use .merge directly on the result of params.permit, you're merging the additional parameters or default values into the hash returned by params.permit.
            .merge(status: "In Progress")
   end
end