class ApplicationsController < ApplicationController
  def show
    @application = Application.all
  end
end