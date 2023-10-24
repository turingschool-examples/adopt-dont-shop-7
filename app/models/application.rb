class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true
  validates :status, presence: :true, inclusion: {in: ["In Progress", "Accepted", "Rejected", "Pending"]}

  def search_pets_by_name(pet_name)
    return [] unless pet_name.present?

    Pet.where("name ILIKE ?", "%#{pet_name}%")
  end

  def approve_a_pet
    @application = Application.find(params[:id])
    @approved_pets = []

    if request.post?
      pet = Pet.find(params[:pet_id])
      @approved_pets << pet

      flash[:notice] = "Pet approved!"
      redirect_to admin_application_path(@application)
    end
  end

  def update_pets_approved 
    @application = Application.find(params[:id]) 
    @approved_pets = [] 

    if params[:approved_pets].present?
      params[:approved_pets].each do |pet_id|
        pet = Pet.find(pet_id)
        @approved_pets << pet
      end
    end

    @application.status = "Approved" if @approved_pets.any?

    if @application.save
      flash[:notice] = "Pet(s) approved!"
    else
      flash[:alert] = "Failed to approve pet(s)."
    end

    redirect_to "/admin/applications/#{@application.id}"
  end

end
