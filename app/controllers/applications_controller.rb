class ApplicationsController < ApplicationController
  def index
    @num_of_applications = Application.all.num_of_applications
  end

  def show
    @application = Application.find(params[:id])
  end
end