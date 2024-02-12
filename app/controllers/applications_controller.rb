class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
    if params[:name_pet].present?
      @pets = Pet.search(params[:name_pet])
    end
  end
  def new
    
  end
  
  
  #   def create 
  #     application = Application.create(application_params)
  #     redirect_to "/applications/#{application.id}"
  #   end
  # end
  
  def create
    application = Application.new(application_params)
    
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:error] = "Fill in the blanks"
      redirect_to "/applications/new"
    end
    
  end


  private

  # def application_params
  #   params.permit(:name, :street_address, :city, :state, :zipcode, :description, :application_status)
  # end

  def application_params
    
    params[:application_status] ||= 'In Progress'

    params.permit(:name, :street_address, :city, :state, :zipcode, :description, :application_status)
  end

end