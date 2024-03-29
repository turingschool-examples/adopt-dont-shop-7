class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new; end

  # def create
  #   Application.create
  # end
end