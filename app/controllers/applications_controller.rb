class ApplicationsController < ApplicationController
  def id
    params[:id]
  end

  def show
    @app = Application.find(id)
  end
end