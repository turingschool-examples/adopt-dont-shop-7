class ApplicationsController < ApplicationController
  def new
  end

  def create
    application = Application.create!({
      name: params[:name],
      address: params[:address],
      address_s: params[:address_s],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      description: params[:description],
      status: "In Progress"
    })

    redirect_to "/applications/#{application.id}"
  end

  def show
    @app = Application.find(id)
    if params[:q]
      @search_results = Pet.where("name ILIKE ?", "%#{params[:q]}%").pluck(:name)
    end
  end

  private

  def id
    params[:id]
  end
end
