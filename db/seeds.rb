# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
@shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    
@pet_1 = @shelter.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
@pet_2 = @shelter.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
@pet_3 = @shelter.pets.create!(adoptable: true, age: 5, breed: "nebelong", name: "Pom Pom", shelter_id: @shelter.id)

@applicant1 = Application.create!(name: "Hannah Banana", street_address: "1234 Sugarwood Cir", city: "Newport", state: "Kentucky", zip_code: "41071", description: "I already have a cat and my cat Dave needs a friend. Dave is very friendly and other cat would be a great addition for our household!")
@applicant2 = Application.create!(name: "Britney Spears", street_address: "250 Zimmerman Rd", city: "Hamburg", state: "New York", zip_code: "14075", description: "I am looking for my first dog. I am always home, because I am working from home. Since I am always around, I will be a great responsible dog owner!")
# @applicant1.pets << @pet_1
# @applicant1.pets << @pet_3
# @applicant2.pets << @pet_2