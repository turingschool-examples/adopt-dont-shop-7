Application.destroy_all
Pet.destroy_all
VeterinaryOffice.destroy_all
Veterinarian.destroy_all
Shelter.destroy_all
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
          @joey = Application.create!(name: "Joey", address: "73 Shifty St", city: "Oakland", state: "MA", zip_code: "09342", description: "I'm a good people, totally not robot", status: "In Progress" )

          shelter = Shelter.create!(foster_program: true, name: "Rickys used pets", city: "Sunnyvale", rank: 1)
          zappa = shelter.pets.create!(adoptable: true, age: 4, breed: "poodle", name: "Francesco Zappa")