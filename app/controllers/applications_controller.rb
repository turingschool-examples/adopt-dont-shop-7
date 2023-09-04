class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:search] != nil
      @searched_pets = Pet.where("name LIKE ?", "%#{params[:search]}%").all
    end
  end

  def new
  end

  def create
    application = Application.create({
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description],
      status: "In Progress"
    })

    if application.new_record? == true
      flash.alert = "All Fields Must be Filled"
      redirect_to "/applications/new"
    else
      redirect_to "/applications/#{application.id}"
    end
  end

  def update
    application = Application.find(params[:id])
    application.update({
      status: "Pending",
      good_owner_reason: params[:good_owner_reason]
    })
    application.save
    redirect_to "/applications/#{application.id}"
  end
end