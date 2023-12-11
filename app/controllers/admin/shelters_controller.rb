class Admin::SheltersController < Admin::ApplicationsController
  def index
    @shelters = Admin.shelters
  end
end
