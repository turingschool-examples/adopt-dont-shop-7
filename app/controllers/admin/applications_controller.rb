class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    # @application = Application.find(params[:id])
    # @pa_status = PetApplication.find(params[:id])
    ## pet application params..
  end
end