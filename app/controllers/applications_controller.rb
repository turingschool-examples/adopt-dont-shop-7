class ApplicationsController < ApplicationController
  def new
  end

  def create
    application = Application.new({
      name: params[:name],
      address: params[:address],
      address_s: params[:address_s],
      city: params[:city],
      state: params[:state],
      zip: params[:zip_code],
      description: params[:description],
      status: params[:status]
    })

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash.alert = "Each field must be complete"
      redirect_to "/applications/new"
    end
  end

  def show
    @app = Application.find(id)
    if params[:q]
      @search_results = Pet.search(params[:q])
    end
  end

  def update
    application = Application.find(params[:id])
    application.update({
      status: "Pending",
      reason_for_good_owner: params[:reason_for_good_owner]
    })
    application.save
    redirect_to "/applications/#{application.id}"
  end

  private

  def id
    params[:id]
  end
end
