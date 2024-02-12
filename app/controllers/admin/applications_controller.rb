class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def update
    require 'pry'; binding.pry
    render :show
  end
end