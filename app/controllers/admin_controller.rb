class AdminController < ActionController::Base
  def shelters_index

  end

  def show
    @application = PetsApplication.find(params[:id])
    @pets = Pet.joins(applicants: :pets_applications)
            .where('pets_applications.applicant_id = ?', @application.applicant_id)
            .select("pets_applications.status", "pets.name", "pets.id")
            .distinct
    # @pets = Applicant.find(@application.applicant_id).pets
  end

  def approve_reject
    @application = PetsApplication.where('pet_id = ?', params[:pet_id])
    @application.update(status: params[:status])
    redirect_to "/admin/applications/#{params[:id]}"
  end
end