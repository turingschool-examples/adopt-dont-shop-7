class VeterinaryOfficeVeterinariansController < ApplicationController

  def index
    @veterinary_office = VeterinaryOffice.find(params[:veterinary_office_id])

    if params[:sort] == "alphabetical"
      @office_vets = @veterinary_office.alphabetical_vets
    elsif params[:review_rating]
      @office_vets = @veterinary_office.office_vets_filtered_by_rating(
        params[:review_rating]
      )
    else
      @office_vets = @veterinary_office.on_call_vets
    end
  end

end
