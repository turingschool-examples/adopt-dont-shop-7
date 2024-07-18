class Admin::SheltersController < ApplicationController
  def index
    if params[:sort].present? && params[:sort] == "pet_count"
      @shelters = Shelter.order_by_number_of_pets
    elsif params[:search].present?
      @shelters = Shelter.search(params[:search])
    else
      @shelters = Shelter.sql_reverse_alphabetical_shelters
    end
    @shelters_pending = Shelter.shelters_pending_applications
  end
end