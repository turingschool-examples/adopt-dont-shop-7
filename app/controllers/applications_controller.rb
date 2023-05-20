class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = PetApplication.where(application: @application.id)
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
    @query = Pet.where(name: params[:search])
  end

  def update
    search
    # require 'pry'; binding.pry
    @pet_application = PetApplication.create!(application: @application, pet: @query.first)
    # @query.first might be problematic.
    redirect_to "/applications/#{@application.id}"
  end

  private
  def application_params

    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end


end