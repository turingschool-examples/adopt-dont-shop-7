class AdminApplicationsController < ApplicationController
  def show
    @app = Application.find(id)
  end

  def update
    require 'pry';binding.pry
  end

  private

  def id
    params[:id]
  end
end
