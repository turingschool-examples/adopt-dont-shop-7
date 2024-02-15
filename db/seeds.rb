
adoption_app_1 = AdoptionApplication.create!(name: "Mel", street_address: "23 Main St", city: "Denver", state: "CO", zip_code: 80303, description: "I have a fenced backyard and love dogs", status: "Pending")
adoption_app_2 = AdoptionApplication.create!(name: "Amy", street_address: "32 Central St", city: "Milwaukee", state: "WI", zip_code: 50204, description: "I make a lot of money", status: "In Progress")
adoption_app_3 = AdoptionApplication.create!(name: "Igor", street_address: "100 1st St", city: "Atlanta", state: "GA", zip_code: 30303, description: "I am a dog person with a lot of money and a fenced backyward", status: "Approved")
adoption_app_4 = AdoptionApplication.create!(name: "Joe", street_address: "200 2nd St", city: "Phoenix", state: "AZ", zip_code: 12344, description: "I hate walking", status: "Rejected")

shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

pet_1 = shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
pet_2 = shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
pet_3 = shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
pet_4 = shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)


vet_office_1 = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
vet_office_2 = VeterinaryOffice.create(name: 'Vets R Us', boarding_services: true, max_patient_capacity: 20)
not_on_call_vet = Veterinarian.create(name: 'Sam', review_rating: 10, on_call: false, veterinary_office_id: vet_office_1.id)

vet_1 = vet_office_1.veterinarians.create(name: "Taylor", review_rating: 10, on_call: true)
vet_2 = vet_office_1.veterinarians.create(name: "Tanya", review_rating: 9, on_call: true)
vet_3 = vet_office_2.veterinarians.create(name: "Jim", review_rating: 8, on_call: true)
not_on_call_vet = vet_office_2.veterinarians.create(name: "Sam", review_rating: 10, on_call: false)

vet_1 = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: vet_office_1.id)
vet_2 = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: vet_office_1.id)
vet_3 = Veterinarian.create(name: 'Sarah', review_rating: 9, on_call: true, veterinary_office_id: vet_office_2.id)
