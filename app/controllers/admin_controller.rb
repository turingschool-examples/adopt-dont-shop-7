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
    if params[:approved] == "true"
      @app.update!(status: 2)
    elsif params[:rejected] == "true"
      @app.update!(status: 3)
    end
    redirect_to "/admin/apps/#{params[:id]}"
  end
end
