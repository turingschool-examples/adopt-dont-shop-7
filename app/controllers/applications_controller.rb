class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    @application = Application.create({
      name: params[:application][:name],
      :full_address = @application.create_full_address(params)
      description: params[:application][:description]
      :status = "Pending"
    })
  end

  # private

end