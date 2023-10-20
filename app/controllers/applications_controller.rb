class ApplicationsController < ApplicationController
  def show 
    @application = Application.find(params[:id])
  #   (name: "Jimmy John", 
  #     street_address: "111 lonely road", 
  #     city: "John City", 
  #     state: "AR", 
  #     zip_code: "90909", 
  #     description: "I like animals", status: "In Progress")
  end
end