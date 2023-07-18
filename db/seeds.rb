# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Destroy existing records
Shelter.destroy_all
Pet.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all
Applicant.destroy_all

# Create shelters
shelters = Shelter.create([
                            { name: 'Shelter 1', city: 'City 1', foster_program: true, rank: 1 },
                            { name: 'Shelter 2', city: 'City 2', foster_program: false, rank: 2 },
                            { name: 'Shelter 3', city: 'City 3', foster_program: false, rank: 3 }
                          ])

# Create veterinary offices
veterinary_offices = VeterinaryOffice.create([
                                               { name: 'Vet Office 1', boarding_services: true,
                                                 max_patient_capacity: 50 },
                                               { name: 'Vet Office 2', boarding_services: false,
                                                 max_patient_capacity: 30 },
                                               { name: 'Vet Office 3', boarding_services: true,
                                                 max_patient_capacity: 40 }
                                             ])

# Create veterinarians
veterinarians = Veterinarian.create([
                                      { name: 'Vet 1', veterinary_office: veterinary_offices.first, on_call: true,
                                        review_rating: 4 },
                                      { name: 'Vet 2', veterinary_office: veterinary_offices.first, on_call: false,
                                        review_rating: 5 },
                                      { name: 'Vet 3', veterinary_office: veterinary_offices.second, on_call: true,
                                        review_rating: 3 }
                                    ])

# Create pets
pets = Pet.create([
                    { name: 'Fluffy', age: 2, breed: 'Breed 1', shelter: shelters.first, adoptable: true },
                    { name: 'Spike', age: 3, breed: 'Breed 2', shelter: shelters.second, adoptable: false },
                    { name: 'Rex', age: 4, breed: 'Breed 3', shelter: shelters.third, adoptable: true }
                  ])

# Create applicants
applicants = Applicant.create([
                                { name: 'Mike Wood', street_address: '123 Main St', city: 'City 1', state: 'State 1', zip_code: 12_345,
                                  description: 'Description 1', status: 'In Progress' },
                                { name: 'John Clay O\'Leary', street_address: '456 Elm St', city: 'City 2', state: 'State 2', zip_code: 67_890,
                                  description: 'Description 2', status: 'In Progress' },
                                { name: 'Jane Fonda', street_address: '789 Oak St', city: 'City 3', state: 'State 3', zip_code: 90_123,
                                  description: 'Description 3', status: 'In Progress' }
                              ])

# Create associations between applicants and pets
applicants.first.applicants_pets.create(pet: pets.first)
applicants.second.applicants_pets.create(pet: pets.second)
applicants.third.applicants_pets.create(pet: pets.third)

# Output a success message
puts 'Sample rows created successfully!'
