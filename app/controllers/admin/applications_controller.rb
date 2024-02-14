class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    # @pets = @application.pets
  end

  def update
    @pet = Pets.find(params[:id])
  end
end