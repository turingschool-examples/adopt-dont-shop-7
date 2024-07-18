Shelter.destroy_all
Pet.destroy_all
VeterinaryOffice.destroy_all
Veterinarian.destroy_all
Application.destroy_all

shelter1 = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 5)
shelter2 = Shelter.create!(name: "Old Man Jenkins Lair", city: "Los Angeles CA", foster_program: true, rank: 10)
pet1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter1.id)
pet2 = Pet.create!(name: "Scrappy", age: 1, breed: "Not So Great Dane", adoptable: true, shelter_id: shelter1.id)
pet3 = Pet.create!(name: "Blue", age: 3, breed: "Blue Dog", adoptable: true, shelter_id: shelter2.id)

app1 = Application.create!(name: "Shaggy",
                            street_address: "1234 Bobs rd",
                            city: "Denver",
                            state: "Colorado",
                            zip_code: "80220",
                            description: "I want a dog!",
                            status: "In Progress")
app2 = Application.create!(name: "Fred",
                            street_address: "1234 Fred rd",
                            city: "Boulder",
                            state: "Colorado",
                            zip_code: "80221",
                            description: "I NEED a dog!",
                            status: "In Progress")

veterinary_office1 = VeterinaryOffice.create!(name: 'Healthy Pets Veterinary Care', boarding_services: true, max_patient_capacity: 40)
veterinary_office2 = VeterinaryOffice.create!(name: 'Paws and Claws Veterinary Clinic', boarding_services: true, max_patient_capacity: 50)
veterinary_office3 = VeterinaryOffice.create!(name: 'Happy Tails Animal Hospital', boarding_services: false, max_patient_capacity: 30)

veterinarian1 = Veterinarian.create!(name: 'Dr. Sarah Johnson', on_call: true, review_rating: 4, veterinary_office_id: veterinary_office1.id)
veterinarian2 = Veterinarian.create!(name: 'Dr. Michael Smith', on_call: false, review_rating: 5, veterinary_office_id: veterinary_office2.id)
veterinarian3 = Veterinarian.create!(name: 'Dr. Emily Davis', on_call: true, review_rating: 4, veterinary_office_id: veterinary_office3.id)
veterinarian4 = Veterinarian.create!(name: 'Dr. Jessica Lee', on_call: true, review_rating: 4, veterinary_office_id: veterinary_office1.id)

PetApplication.create!(application: app1, pet: pet1, status: "Pending")
PetApplication.create!(application: app1, pet: pet2, status: "Pending")

PetApplication.create!(application: app2, pet: pet1, status: "Pending")
PetApplication.create!(application: app2, pet: pet2, status: "Pending") 