class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def update
    render :show
  end
end