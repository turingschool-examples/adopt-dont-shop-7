class AdoptionApplicationController < ApplicationController

   def show
      @adoption_app = AdoptionApplication.find(params[:id])
      
      @pets = Pet.search(params[:search])

      if params[:add_pet].present?
         pet_id = params[:add_pet]
         @adoption_app.add_pet_to_app(pet_id)
      end

      if params[:ownership_description].present?
         @adoption_app.change_app_status("Pending")
         @adoption_app.add_ownership_description_to_app(params[:ownership_description])
      end
   end

   def new
   end

   def create      
      adoption_app = AdoptionApplication.new(adoption_app_params)
      if adoption_app.save 
         redirect_to "/applications/#{adoption_app.id}"
      else
         
         flash.now[:alert] = "Error: #{error_message(adoption_app.errors)}"
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
                     :status,
                     :search,
                     :add_pet,
                     :ownership_description)
   end
end