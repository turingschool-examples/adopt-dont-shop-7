class Admin::ApplicationsController < ApplicationsController
  def show
    @application = Application.find(params[:id])
  end
end