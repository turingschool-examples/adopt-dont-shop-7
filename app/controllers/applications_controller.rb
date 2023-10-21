class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
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
        status: "Pending"
      })
      application.save
      redirect_to "/applications/#{application.id}"
    end
  end

  # private


end