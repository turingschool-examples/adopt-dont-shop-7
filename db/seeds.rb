# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all

shelter_1 = Shelter.create!(foster_program: true, name: "Denver Animal Shelter", city: "Denver", rank: 1)
shelter_2 = Shelter.create!(foster_program: false, name: "Aurora Animal Shelter", city: "Aurora", rank: 2)

pet_1 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter_1.id)
pet_2 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Fido", shelter_id: shelter_1.id)
pet_3 = Pet.create!(adoptable: true, age: 5, breed: "lab", name: "Sir Maximus", shelter_id: shelter_2.id)
pet_4 = Pet.create!(adoptable: true, age: 7, breed: "norwegian forest cat", name: "Sven", shelter_id: shelter_2.id)

application_1 = Application.create!(name_of_applicant: "Matt Lim", street_address: "1234 Example St", city: "Denver", state: "CO", zip_code: 80202, description: "I love animals", application_status: "Pending", shelter_id: shelter_1.id)
application_2 = Application.create!(name_of_applicant: "Jorja Fleming", street_address: "5678 Sample St", city: "Denver", state: "CO", zip_code: 80202, description: "I am lonely and need cats", application_status: "Pending", shelter_id: shelter_1.id)
application_3 = Application.create!(name_of_applicant: "Tim Nordloh", street_address: "9012 Test St", city: "Denver", state: "CO", zip_code: 80202, description: "I am starting Noahs's Ark", application_status: "Pending", shelter_id: shelter_2.id)
application_4 = Application.create!(name_of_applicant: "Eric Coats", street_address: "3456 Try St", city: "Denver", state: "CO", zip_code: 80202, description: "doggies woof woof", application_status: "Pending", shelter_id: shelter_2.id)

application_1.pets << pet_1


