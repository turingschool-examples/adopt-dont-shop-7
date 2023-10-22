# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

@admin = Admin.create
@application_1 = @admin.applications.create(name: "Bob", address: "123 1st St", city: "Pleasantville", state: "CO", zipcode: 80501, description: "they're cute", status: "In Progress")
@shelter = @admin.shelters.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

@pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
@pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
@pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: @shelter.id)

@pet_1.applications << @application_1
@pet_2.applications << @application_1