class AppsController < ApplicationController
  def index

  end

  def show
    @apps = App.find(params[:id])
  end
end