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
    
    # require 'pry'; binding.pry
    if params[:approved] == true
      # require 'pry'; binding.pry
      @app.update!(status: 2)
      redirect_to "/admin/apps/#{params[:id]}"

    elsif params[:rejected] == true
      @app.update!(status: 3)
      redirect_to "/admin/apps/#{params[:id]}"

    else @app.update!(status: 1)
      redirect_to "/admin/apps/#{params[:id]}"
    end
  end
end
