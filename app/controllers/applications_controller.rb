class ApplicationsController < ApplicationController
  def show
        @applicant = Application.find(params[:id])
        @pets = @applicant.pets
  end
end

