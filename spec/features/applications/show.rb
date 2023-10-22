require "rails_helper"

RSpec.describe "Applications show page" do

  describe "applications#show" do
    it "shows the applicants contact info." do

      shelter_1 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)

      pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter_1.id)
      pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter_1.id)

  
      @application_1 = Application.create!({

        name: "Joe Smith", 
        street_addr: "2323 Wysteria Ln.",
        city: "Littleton",
        state: "CO",
        zip: "89321",
        description: "Love pets; live on farm",
        pet_names: ["Lucille Bald", "Lobster"],
        status: "Pending"
      })

      visit "/applications/#{@application_1.id}"

      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.street_addr)
      expect(page).to have_content(@application_1.city)
      expect(page).to have_content(@application_1.state)
      expect(page).to have_content(@application_1.zip)
      expect(page).to have_content(@application_1.description)
      
      expect(page).to have_content(@application_1.pet_names)
      expect(page).to have_content(@application_1.status)

      save_and_open_page
    end
  end
end 

