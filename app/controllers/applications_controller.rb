class ApplicationsController < ActionController

  def show
    @application = Application.find(params[:id])
  end

end