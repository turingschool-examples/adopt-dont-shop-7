class Admin::ApplicationsController < ApplicationController

  def index
    @application = Application.find(params[:id])
  end
  
end