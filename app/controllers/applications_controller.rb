class ApplicationsController < ApplicationController
  def show 
    @app = Application.find(params[:id]) 
    @pets = @app.pets
    if params[:search]
      @found_pets = Pet.search(params[:search])
    end
  end 

  def new; end

  def create
    new_app = Application.new(strong_params)
    if new_app.save
      redirect_to "/applications/#{new_app.id}"
    else 
      flash[:notice] = "Missing required inputs"
      redirect_to "/applications/new"
    end 
  end

  def update
    app = Application.find(params[:id]) 
    app.update!(description: params[:description], status: 1)
    redirect_to "/applications/#{app.id}"
  end

  private 

  def strong_params
    params.permit(:name,
                  :street_address,
                  :city, 
                  :state,
                  :zip,
                  :description)
  end
end 