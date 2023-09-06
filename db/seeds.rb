# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

#shelters
@shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
@shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
@shelter_3 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

#pets
@pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
@pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
@pet_3 = @shelter_1.pets.create!(name: "Snoopy", breed: "beagle", age: 11, adoptable: false)
@pet_4 = @shelter_2.pets.create!(name: "Tiger", breed: "Labradoodle", age: 4, adoptable: true)
@pet_5 = @shelter_2.pets.create!(name: "Mr. T", breed: "Great Dane", age: 5, adoptable: true)
@pet_6 = @shelter_2.pets.create!(name: "Speckles", breed: "Mutt", age: 2, adoptable: false)
@pet_7 = @shelter_3.pets.create!(name: "Beckett", breed: "Lab Mix", age: 13, adoptable: true)
@pet_8 = @shelter_3.pets.create!(name: "Pistachio", breed: "French BullDog", age: 3, adoptable: true)
@pet_9 = @shelter_3.pets.create!(name: "ButtCheek", breed: "Bulldog", age: 6, adoptable: false)

#applications
@cory = Application.create!(name:"Cory", street_address: "385 N Billups st.", city: "Athen", state: "GA", zipcode:"30606", description:"Extremely normal and can be trusted", status:"In Progress" )
@antoine = Application.create!(name:"Antoine", street_address: "1244 Windsor Street", city: "Salt Lake City", state: "UT", zipcode:"84105", description:"need to strengthen fingers through petting", status:"In Progress" )
@jeff = Application.create!(name:"Jeff", street_address: "1244 Windsor Street", city: "Salt Lake City", state: "UT", zipcode:"84105", description:"need to strengthen fingers through petting", status:"In Progress" )


#PetApplications
# @pet_applications_1 = PetApplication.create!(pet_id: "#{@pet_1.id}", application_id: "#{@cory.id}", status: "Pending" )
# @pet_applications_2 = PetApplication.create!(pet_id: "#{@pet_4.id}", application_id: "#{@antoine.id}", status: "Approved" )
# @pet_applications_3 = PetApplication.create!(pet_id: "#{@pet_3.id}", application_id: "#{@jeff.id}", status: "Approved" )
# @pet_applications_4 = PetApplication.create!(pet_id: "#{@pet_1.id}", application_id: "#{@antoine.id}", status: "Approved" )