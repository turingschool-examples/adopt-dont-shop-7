class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @address = @application.address
  end
end