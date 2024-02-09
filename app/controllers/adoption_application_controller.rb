class AdoptionApplicationController < ApplicationController
   def index
      @adotpion_apps = AdoptionApplication.all
      
   end

   def show
      @adoption_app = AdoptionApplication.find(params[:id])
      if params[:search]
         @pets = Pet.search(params[:search])
      elsif params[:add_pet].present?
         pet_id = params[:add_pet]
         @adoption_app.add_pet_to_app(pet_id)
      end

      if params[:ownership_description].present?
         @adoption_app.change_application_status("Pending")
      end
   end

   def new
   end

   def create      
      adoption_app = AdoptionApplication.create(adoption_app_params)
      if adoption_app.save 
         redirect_to "/applications/#{adoption_app.id}"
      else
         flash[:notice] = "Application incomplete. Please fill out all fields."
         render :new
      end
   end

   private
   def adoption_app_params 
      params.permit(:id, 
                     :name,
                     :street_address,
                     :city,
                     :state,
                     :zip_code,
                     :description,
                     :status).merge(status: "In Progress")
      # when you use .merge directly on the result of params.permit, you're merging the additional parameters or default values into the hash returned by params.permit.
   end
end