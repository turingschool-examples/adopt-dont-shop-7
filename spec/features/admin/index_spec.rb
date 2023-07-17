require "rails_helper"

RSpec.describe "Admin shelter index" do 
    before(:each) do
        @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
        @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

        @applicant_1 = Applicant.create(name: "Ian", street_address: "4130 cleveland ave", city: "New Orleans", state: "louisiana", zip_code: 70119, description: "I wanna have cat")
        @applicant_2 = Applicant.create(name: "Ian", street_address: "850 utica", city: "Denver", state: "Colorado", zip_code: 80204, description: "I need cat")

        @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
        @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
        @pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
        @pet_4 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

        @applicant_pet_1 = ApplicantPet.create(pet_id: @pet_1.id, applicant_id: @applicant_1.id)
        @applicant_pet_2 = ApplicantPet.create(pet_id: @pet_3.id, applicant_id: @applicant_2.id)

    end
    
    describe "When I visit the admin/shelters" do
        it "Shows the list of shelters in reverse alphabetical order" do
            visit "/admin/shelters" 

            within '#ordered_shelters' do
            expect(@shelter_2.name).to appear_before(@shelter_3.name)
            expect(@shelter_3.name).to appear_before(@shelter_1.name)
            end
            
        end
        
        it 'Shows a list of shelters with pending applications' do
            visit "/admin/shelters" 

            within '#pending_apps' do
                expect(page).to have_content(@shelter_1.name)
                expect(page).to have_content(@shelter_3.name)
            end
        end
    end
end