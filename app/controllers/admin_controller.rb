class AdminController < ApplicationController
  def index
    @shelters = Shelter.order_by_name_reverse
    @pendingshelters = Shelter.shelters_apps_in_progress
  end

  def show
    @app = App.find(params[:id])
  end

  def update
    @app = App.find(params[:id])
    @app.update!(status: 2)
    redirect_to "/admin/apps/#{params[:id]}"
  end
end
