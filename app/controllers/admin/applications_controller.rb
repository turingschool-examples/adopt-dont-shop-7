class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end
  def update
    pet = Pet.find(params[:pet_id])
  end
end