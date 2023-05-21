require "rails_helper"

RSpec.describe "application update", type: :feature do
  describe "application#update" do
    before(:each) do
      @shelter1 = Shelter.create!(foster_program: true, name: "Bishop Animal Rescue", city: "Bishop", rank: 5)
      @pet1 = @shelter1.pets.create!(adoptable: true, age: 3, breed: "Samoyed", name: "Fluffy")
      @pet2 = @shelter1.pets.create!(adoptable: true, age: 6, breed: "Husky", name: "Hubert")
      # ^ not applied by anyone
      @pet3 = @shelter1.pets.create!(adoptable: true, age: 8, breed: "Shiba Inu", name: "Shishi")

      @shelter2 = Shelter.create!(foster_program: true, name: "Chicago Animal Rescue", city: "Chicago", rank: 4)
      @pet4 = @shelter2.pets.create!(adoptable: true, age: 1, breed: "Lab", name: "Lally")
      @pet5 = @shelter2.pets.create!(adoptable: true, age: 10, breed: "Chihuahua", name: "Chewy")

      @shelter3 = Shelter.create!(foster_program: true, name: "Los Angeles Animal Rescue", city: "Los Angeles", rank: 3)
      @pet6 = @shelter3.pets.create!(adoptable: true, age: 5, breed: "Pitbull", name: "Bully")

      @app1 = Application.create!(name: "Garrett", street_address: "123 Upland", city: "Bishop", state: "CA", zip_code: "12345", description: "I'm the best -DJ Khaled", status: "In Progress")
      @petapp1 = PetApplication.create!(application_id: @app1.id, pet_id: @pet1.id)
      @petapp2 = PetApplication.create!(application_id: @app1.id, pet_id: @pet4.id)

      @app2 = Application.create!(name: "Andy", street_address: "456 Downtown", city: "Anywhere", state: "HI", zip_code: "23456", description: "Anotha One -DJ Khaled", status: "Pending")
      @petapp3 = PetApplication.create!(application_id: @app2.id, pet_id: @pet1.id)
      @petapp4 = PetApplication.create!(application_id: @app2.id, pet_id: @pet3.id)
      @petapp5 = PetApplication.create!(application_id: @app2.id, pet_id: @pet6.id)

      @app3 = Application.create!(name: "Jeff", street_address: "567 Sideways", city: "Somewhere", state: "DE", zip_code: "34567", description: "We the best -DJ Khaled", status: "Rejected")
      @petapp6 = PetApplication.create!(application_id: @app3.id, pet_id: @pet5.id)
    end

    it "updates a Pet application with pet id and application id" do
      # 5. Add a Pet to an Application

      # As a visitor
      # When I visit an application's show page
      # And I search for a Pet by name
      # And I see the names Pets that match my search
      # Then next to each Pet's name I see a button to "Adopt this Pet"
      # When I click one of these buttons
      # Then I am taken back to the application show page
      # And I see the Pet I want to adopt listed on this application
      visit "/applications/#{@app1.id}/?search=#{@pet2.name}"

      within "#pets-#{@app1.id}" do
        expect(page).to_not have_content("Name: #{@pet2.name}")
      end

      visit "/applications/#{@app1.id}/?search=#{@pet2.name}"

      expect(page).to have_content("Add a Pet to this Application")
      # save_and_open_page

      click_button("Adopt this Pet")

      within "#pets-#{@app1.id}" do
        expect(page).to have_content("Name: #{@pet1.name}")
        expect(page).to have_content("Name: #{@pet2.name}")
        expect(page).to have_content("Name: #{@pet4.name}")
      end
    end
  end

end