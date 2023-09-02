class AdminController < ActionController::Base
  def shelters_index
    @shelters = Shelter.order_by_name_alphabetical
    @pending_apps = Shelter.with_pending_applications
  end

  def applications_show
    
  end
end