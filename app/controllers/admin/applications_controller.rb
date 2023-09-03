class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  
    @pets = Pet.joins(:applications).where(applications: {id: @application.id})
    
    @status = ApplicationPet.where(application_id: "#{@application.id}")
  end
end