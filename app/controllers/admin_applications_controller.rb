class AdminApplicationsController < ApplicationController
  def show
    @app = Application.find(id)
  end

  private

  def id
    params[:id]
  end
end
