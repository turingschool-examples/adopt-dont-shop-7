class AdminController < ActionController::Base
  def shelters_index
    @shelters = Shelter.order_by_name_alphabetical
  end

  def applications_show
    
  end
end