class Admin::SheltersController < ApplicationController 
  def index 
    @shelters = Shelter.all
  end

  def show
    shelter_id = params[:id]
    @shelter_name = Shelter.find_by_sql("SELECT name FROM shelters WHERE id = #{shelter_id}").first&.name
    @shelter_address = Shelter.find_by_sql("SELECT city FROM shelters WHERE id = #{shelter_id}").first&.city
    
    #wondering which method to put these ^^ in for admin.
    #I tried making an admin/shelter model
    #I also tried putting it in the shelter model
    #neither worked, might not be setting up the new model correctly
  end
end 
