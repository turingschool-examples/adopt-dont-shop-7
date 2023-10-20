require 'rails_helper' 

RSpec.describe "Application Show Page", type: :feat do 
  let(:shelter) { Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9) } 
  let(:application1) { Application.create({name: "John", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I lika da pets", status: "In Progress"}) } 
  let(:pet1) { Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id) } 
  let(:pet2) { Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id) } 
  describe "visiting the application show page" do 
    it 'shows the applicant and all the applicants details' do 
      visit "/applications/#{application1.id}"

      expect(page).to have_content("Name: #{application1.name}")
      expect(page).to have_content("Street Address: #{application1.street_address}")
      expect(page).to have_content("City: #{application1.city}")
      expect(page).to have_content("State: #{application1.state}")
      expect(page).to have_content("Zip Code: #{application1.zip_code}")
      expect(page).to have_content("Why I would make a good home: #{application1.description}")
      expect(page).to have_content("Applying to Adopt:" )
      expect(page).to have_content("Status: #{application1.status}")
    end
  end
end 
