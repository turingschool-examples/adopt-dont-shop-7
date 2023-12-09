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
@application = Application.create!(name: 'Taylor', street_address: '123 Side St', city: 'Denver', state: 'CO', zip_code: '80202', description: 'Big yard', application_status: 'In Progress')
@application_2 = Application.create!(name: 'John', street_address: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80202', description: 'Live alone', application_status: 'In Progress')
@application_3 = Application.create!(name: 'Jane', street_address: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80202', description: 'Animal-proof safety measures', application_status: 'In Progress')
@shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) 
@shelter_2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 9)
@shelter_3 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
@bella = @shelter.pets.create!(name: 'Bella', age: 1, breed: 'Golden', adoptable: true) 
@rigby = @shelter.pets.create!(name: 'Rigby', age: 2, breed: 'Mix', adoptable: true) 
@luna = @shelter.pets.create!(name: 'Luna', age: 4, breed: 'Pitbull', adoptable: true) 
@clawdia = @shelter_2.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
@lobster = @shelter_3.pets.create!(name: 'Lobster', breed: 'Dachsund', age: 1, adoptable: true)
@pa_1 = PetApplication.create!(pet: @bella, application: @application, status: "In progress")
@pa_2 = PetApplication.create!(pet: @rigby, application: @application, status: "In progress")
@pa_3 = PetApplication.create!(pet: @luna, application: @application, status: "In progress")
@pa_4 = PetApplication.create!(pet: @clawdia, application: @application_2, status: "In progress")
@pa_5 = PetApplication.create!(pet: @clawdia, application: @application_3, status: "In progress")