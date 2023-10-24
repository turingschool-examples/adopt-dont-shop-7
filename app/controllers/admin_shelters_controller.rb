class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql ["SELECT * FROM shelters ORDER BY name DESC"]

    # @app_shelter = Pet.select("pets.shelters").joins(:applicants).where("applicant.applicant_status = pending").pluck(:shelters)
    @shelters_list = Shelter.all.joins(pets: [pet_applications: :application]).where("applications.application_status = 'pending'")

    # require'pry';binding.pry
  end
end