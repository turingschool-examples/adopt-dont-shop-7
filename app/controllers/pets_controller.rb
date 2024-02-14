class PetsController < ApplicationController
  def index
    index_filter
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    create_filter
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    update_filter
  end

  def destroy
    Pet.find(params[:id]).destroy
    redirect_to "/pets"
  end

  private

  def pet_params
    params.permit(:id, :name, :age, :breed, :adoptable, :shelter_id)
  end

  def index_filter
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
      @pets = Pet.adoptable
    end
  end

  def update_filter
    pet = Pet.find(params[:id])
    if pet.update(pet_params)
      redirect_to "/pets/#{pet.id}"
    else
      redirect_to "/pets/#{pet.id}/edit"
      flash[:alert] = "Error: #{error_message(pet.errors)}"
    end
  end

  def create_filter
    pet = Pet.new(pet_params)
    if pet.save
      redirect_to "/shelters/#{pet_params[:shelter_id]}/pets"
    else
      redirect_to "/shelters/#{pet_params[:shelter_id]}/pets/new"
      flash[:alert] = "Error: #{error_message(pet.errors)}"
    end
  end
end
