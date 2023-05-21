class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pet_applications = PetApplication.where(application: @application.id)
  end

  def new
  end
  
  def create
      # if !application_params.each do |param|
      #     param.blank?
      # end
      @application = Application.new(application_params)
      # require 'pry'; binding.pry
      if @application.save
        redirect_to "/applications/#{@application.id}"
      else
      redirect_to "/applications/new"
      end
  end

  def search
    show
    @query = Pet.where("lower(name) ILIKE ?", ("%#{params[:search]}%").downcase)
  end

  def update
    show
    @application.update(application_status: "Pending")
    # @query.first might be problematic.
    redirect_to "/applications/#{@application.id}"
  end

  private
  def application_params

    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end

end

