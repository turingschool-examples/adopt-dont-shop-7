class ApplicationsController < ApplicationController

  def show
    if params.keys.any? { |key| key == "search" }
      @application = Application.find(params[:id])
      @searched = Application.searched_pet(params)
    else
      @application = Application.find(params[:id])
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