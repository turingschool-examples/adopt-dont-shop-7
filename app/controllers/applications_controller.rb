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
    else
      @has_pets = @application.has_pets?
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
        good_home: params[:good_home],
        status: "In Progress"
      })
      application.save
      redirect_to "/applications/#{application.id}"
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.update({
      name: @application.name,
      full_address: @application.full_address,
      good_home: @application.good_home,
      good_owner: params[:good_owner],
      status: "Pending"
    })
    @application.save
    redirect_to "/applications/#{@application.id}"
  end
end