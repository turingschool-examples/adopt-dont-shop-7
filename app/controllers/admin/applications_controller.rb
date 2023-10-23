class Admin::ApplicationsController < ApplicationController
  def show
    @application.approve_a_pet
  end

    def update
    @application.update_pets_approved

end
