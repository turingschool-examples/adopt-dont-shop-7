class AdminsController < ActionController::Base
  def index
    @shelters = Shelter.order_by_reverse_alphabetically
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def show
    @application = Application.find(params[:id])
  end

  def destroy

  end
end