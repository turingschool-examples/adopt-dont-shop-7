class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def create_full_address(params)
    require 'pry'; binding.pry
    address = "#{params[:street_address] params[:city] params[:state] params[:zip_code]}"

  end
end
