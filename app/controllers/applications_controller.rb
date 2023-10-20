class ApplicationsController < ApplicationController

  def show
    # require'pry';binding.pry
    @application = Application.find(params[:id])
  end

end