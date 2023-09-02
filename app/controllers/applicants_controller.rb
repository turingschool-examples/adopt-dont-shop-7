class ApplicantsController < ApplicationController
  def index

  end
  
  # def pet_names
  #   pets_array = []
  #   pets_array << @applicant.pets
  # end

  def show
    @applicant = Applicant.find(params[:id])
    @pets = Applicant.pets.split(" ")
  end

end