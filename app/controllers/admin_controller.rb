class AdminController < ApplicationController
  def shelters_index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
  end

  def applications_show
    @application = Application.find(params[:id])
  end

  def applications_update
    @application = Application.find(params[:id])
    @pet_application = PetApplication.find(params[:application_id, pet_id])
  end
end
