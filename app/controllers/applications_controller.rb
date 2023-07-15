class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @results = Pet.search(params[:search])
  end

  def new

  end

  def create
    application = Application.new(
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zipcode: params[:zipcode],
      reason_for_adoption: params[:reason_for_adoption],
      status: "In Progress"
    )
    # sort out strong_params later; would (app_params, status: "In Progress") work?
    
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end

    # errors is a built in ActiveModel method
    # generates an object like #<ActiveModel::Errors [#<ActiveModel::Error attribute=name, type=blank, options={}>]>
    # then calling .full_messages on this object will return an error message in plain English like "Name can't be blank"
  end

  # Multiple ways to raise an error:
  # flash.alert
  # flast[:alert]
  # redirect_to "path here", notice: "error message"

  # error code is saved in application controller (original)
  # def error_message(errors)
  #   errors.full_messages.join(', ')
  # end
end