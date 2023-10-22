class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def pet_show
    @pet = Pet.find(params[:id])
  end

  def status
    if pet_names.length == ""
      "In Progress"
    else
      "Pending"
    end
  end

  def in_progress?
    status == "In Progress"
  end

end