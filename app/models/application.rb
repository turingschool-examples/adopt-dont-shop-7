class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def address_join
    #ActiveRecord coding to join the entire address together
  end
end