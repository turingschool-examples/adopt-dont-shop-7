class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
  end

  def show
    @application = Application.find(params[:app_id])
  end

  def update
    application = Application.find(params[:app_id])
    application.pet_applications.each do |pa|
      if pa.id == params[:pa_id].to_i
        pa.update({
          pet_app_status: [params[:new_status]]
        })
        application.update(status: params[:new_status])
        pa.save
      end
    end

    redirect_to "/admin/shelters/#{application.id}"
  end
end