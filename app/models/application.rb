class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def self.empty_params_link(params)
    queries = Application.empty_params(params)
    link = "/applications/new"
    queries.each_with_index do |query, index|
      if index == 0
        link += "?#{query}=true"
      else
        link += "&#{query}=true"
      end
    end
    link
  end

  def self.empty_params(params)
    params.select { |key, value| value ==  ""}.keys
  end

  def self.create_full_address(params)
    "#{params[:street_address]}, #{params[:city]}, #{params[:state]}, #{params[:zip_code]}"
  end
end
