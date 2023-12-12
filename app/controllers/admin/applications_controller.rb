class Admin::ApplicationsController < ApplicationController
  def show
    # require 'pry'; binding.pry
    @applications = Application.find(params[:id])
  end
end