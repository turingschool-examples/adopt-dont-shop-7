class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def self.num_of_applications
    self.count
  end

  # def find_pets
    # binding.pry
    # Application.joins(:application_pets).select("Application.id, application_pets.pets_id")

    #Booking.joins(:ratings).select("bookings.id, ratings.comments")

    # SELECT "bookings"."id", "ratings"."comments" 
    # FROM "bookings" 
    # INNER JOIN "ratings" 
    # ON "ratings"."booking_id" = "bookings"."id"
  # end
end