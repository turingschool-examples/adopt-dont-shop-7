class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if params[:adopt] != nil
      if !@application.pets.include?(Pet.find(params[:adopt])) 
        @application.pets << Pet.find(params[:adopt])
      else
        @already_adopted = true
      end
    end
    if params.keys.any? { |key| key == "search" }
      @searched = Application.searched_pet(params)
    end
  end

  def new
  end

  def create
    if params.values.any? { |value| value == "" }
      redirect_to Application.empty_params_link(params)
    else
      application = Application.new({
        name: params[:name],
        full_address: Application.create_full_address(params),
        description: params[:description],
        status: "In Progress"
      })
      application.save
      redirect_to "/applications/#{application.id}"
    end
  end
end