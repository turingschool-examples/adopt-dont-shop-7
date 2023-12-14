class Admin::SheltersController < ApplicationController
  def index
    if params[:sort].present? && params[:sort] == "pet_count"
      @shelters = Shelter.order_by_number_of_pets
    elsif params[:search].present?
      @shelters = Shelter.search(params[:search])
    else
      @shelters = Shelter.order_shelters_reverse_alphabetically
    end

    @application_shelters = Shelter.list_shelters_with_pending_applications
  end
end