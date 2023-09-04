class ApplicationsController < ApplicationController
  def show 
    @application = Application.find(params[:id])
    @searched_pets = Pet.search(params[:pet_search])
  end

  def new

  end

  def create
    application = Application.create(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Please fill in all fields."
      render :new
    end
  end

  private
    def application_params
      full_addr = "#{params[:addr]}, #{params[:city]}, #{params[:state]}, #{params[:zip]}"
      params.permit(:name, :description).merge(address: full_addr, status: "In Progress")
    end
end