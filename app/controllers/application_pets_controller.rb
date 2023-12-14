class ApplicationPetsController < ApplicationController
  def index

  end

  def new

  end

  def create
  @application_pet = ApplicationPet.create(application_pet_params)

    redirect_to show_application_path
  end

  def edit

  end

  def update
    application_pet = ApplicationPet.find_by("pet_id = ? and application_id = ?", params[:pet_id], params[:id]) #move this to model method

    if params[:filter] == "approved"
      application_pet.update(application_approved: true)
      Pet.set_adoptable_false(params[:pet_id]) #find_pet(name).update(adoptable: false)
    else
      application_pet.update(application_approved: false)
    end
    # redirect_to pets_update_path
    # redirect_to controller: :pets, action: :update, id: params[:pet_id], method: :patch
    # redirect_to "_method"=>"patch", "filter"=>"approved", "controller"=>"pets", "action"=>"update", "id"=>"#{params[:pet_id]}"
    # redirect_to  "/pets/#{params[:pet_id]}", method: :patch

    redirect_to show_admin_applications_path
  end

  def show

  end

  def destroy

  end

  private

  def application_pet_params
    params.permit(:pet_id, :application_id)
  end
end
