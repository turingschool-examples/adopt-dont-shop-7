class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
 
  validates_presence_of :name, :street, :city, :state, :zip, :descr, :status

  enum status: {"In progress": 0, "Pending": 1, "Approved": 2, "Rejected": 3}

  def pet_search(name) 
    Pet.where("name = ?", name)
  end

  # def pet_search_partial(name)
  #   Pet.search(name)
  # end

end