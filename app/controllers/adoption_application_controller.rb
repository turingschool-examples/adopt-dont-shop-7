class AdoptionApplicationController < ApplicationController
   # We don't need a index since it's not being asked in the user stories. YAGNI

   def show
      @adoption_app = AdoptionApplication.find(params[:id])
      
      @pets = Pet.search(params[:search])

      # Add pet to the application
      if params[:add_pet].present?
         pet_id = params[:add_pet]
         @adoption_app.add_pet_to_app(pet_id)
      end

      # If we fill out ownership description, we automatically change the status
      if params[:ownership_description].present?
         @adoption_app.change_app_status("Pending")
      end
   end

   def new
   end

   def create      
      adoption_app = AdoptionApplication.create(adoption_app_params)
      if adoption_app.save 
         redirect_to "/applications/#{adoption_app.id}"
      else
         # saw this error in the other controllers and it's pretty cool. It calls a method in Application Controller
         redirect_to "/applications/new"
         flash[:alert] = "Error: #{error_message(adoption_app.errors)}"
      end
   end

   private
   def adoption_app_params 
      params.permit(
      :name,
      :street_address,
      :city,
      :state,
      :zip_code,
      :description,
      :status)
      # when you use .merge directly on the result of params.permit, you're merging the additional parameters or default values into the hash returned by params.permit.
      # .merge(status: "In Progress")  
      
      # we don't need this anymore since we set up as default in the migration
   end
end