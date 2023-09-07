class AdminController < ApplicationController
  def index
    @shelters = Shelter.alphabetical_sort
    @shelters_pending = Shelter.pending_applications
  end

  def show
    @application = Application.find(params[:id])
  end

  def update
    relationship = ApplicationPet.where("pet_id = ? AND application_id = ?", params[:pet_id], params[:application_id])
    if params[:status] == "approved"
      relationship.first.update({status: "Approved"})
    else
      relationship.first.update({status: "Rejected"})
    end

    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end
