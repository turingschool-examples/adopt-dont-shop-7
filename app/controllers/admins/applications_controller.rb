class Admins::ApplicationsController < ApplicationController

  def show
    @application = Application.application(params[:id])
  end


  def update
  end
end
