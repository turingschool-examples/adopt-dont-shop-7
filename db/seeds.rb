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
Vetrinarian.destroy_all
Veterinary_office.destroy_all

  aurora_shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
  rgv_animal_shelter = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
  fancy_pets_colorado = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
      
  mr_pirate = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
  clawdia = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
  lucille_bald = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
  ann = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

  john = Application.create(name: "John", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I need a companion!", status: "Pending")
  jessica = Application.create(name: "Jessica", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I need a companion!", status: "Pending")
  craig = Application.create(name: "Craig", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I need a companion!", status: "In Progress")
  hope = Application.create(name: "Hope", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I need a companion!", status: "In Progress")

  pet_app_1 = PetApplication.create!(application_id: "#{@application_1.id}", pet_id: "#{@pet_3.id}", status: "Pending")
  pet_app_2 = PetApplication.create!(application_id: "#{@application_2.id}", pet_id: "#{@pet_1.id}", status: "Pending")
  pet_app_3 = PetApplication.create!(application_id: "#{@application_3.id}", pet_id: "#{@pet_3.id}", status: "Pending")
  pet_app_4 = PetApplication.create!(application_id: "#{@application_4.id}", pet_id: "#{@pet_2.id}", status: "Pending")

  vet_office_1 = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
  vet_office_2 = VeterinaryOffice.create(name: 'Vets R Us', boarding_services: true, max_patient_capacity: 20)

  not_on_call_vet = Veterinarian.create(name: 'Sam', review_rating: 10, on_call: false, veterinary_office_id: @vet_office_1.id)
  vet_1 = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: @vet_office_1.id)
  vet_2 = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: @vet_office_1.id)
  vet_3 = Veterinarian.create(name: 'Sarah', review_rating: 9, on_call: true, veterinary_office_id: @vet_office_2.id)

