require "rails_helper"

RSpec.describe "Applications", type: :feature do
  describe "application#show" do
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

      @app1 = Application.create!(name: "Garrett", street_address: "123 Upland", city: "Bishop", state: "CA", zip_code: "12345", description: "I'm the best -DJ Khaled")
      @petapp1 = PetApplication.create!(application_id: @app1.id, pet_id: @pet1.id, status: "In Progress")
      @petapp2 = PetApplication.create!(application_id: @app1.id, pet_id: @pet4.id, status: "Pending")

      @app2 = Application.create!(name: "Andy", street_address: "456 Downtown", city: "Anywhere", state: "HI", zip_code: "23456", description: "Anotha One -DJ Khaled")
      @petapp3 = PetApplication.create!(application_id: @app2.id, pet_id: @pet1.id, status: "Pending")
      @petapp4 = PetApplication.create!(application_id: @app2.id, pet_id: @pet3.id, status: "Pending")
      @petapp5 = PetApplication.create!(application_id: @app2.id, pet_id: @pet6.id, status: "Accepted")

      @app3 = Application.create!(name: "Jeff", street_address: "567 Sideways", city: "Somewhere", state: "DE", zip_code: "34567", description: "We the best -DJ Khaled")
      @petapp6 = PetApplication.create!(application_id: @app3.id, pet_id: @pet5.id, status: "Rejected")

    end

    # 1. Application Show Page

    # As a visitor
    # When I visit an applications show page
    # Then I can see the following:
    # - Name of the Applicant
    # - Full Address of the Applicant including street address, city, state, and zip code
    # - Description of why the applicant says they'd be a good home for this pet(s)
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

    it "shows a specific application" do
      visit "/applications/#{@app1.id}"

      expect(page).to have_content("Name: #{@app1.name}")
      expect(page).to have_content("Street Address: #{@app1.street_address}")
      expect(page).to have_content("City: #{@app1.city}")
      expect(page).to have_content("State: #{@app1.state}")
      expect(page).to have_content("Zip Code: #{@app1.zip_code}")
      expect(page).to have_content("Description: #{@app1.description}")

      # save_and_open_page
      expect(page).to have_link(@pet1.name, href: "/pets/#{@pet1.id}")
      expect(page).to have_link(@pet4.name, href: "/pets/#{@pet4.id}")
      expect(page).to have_content(@petapp1.status)
      expect(page).to have_content(@petapp2.status)
    end

    it "shows a specific application" do
      visit "/applications/#{@app2.id}"

      expect(page).to have_content("Name: #{@app2.name}")
      expect(page).to have_content("Street Address: #{@app2.street_address}")
      expect(page).to have_content("City: #{@app2.city}")
      expect(page).to have_content("State: #{@app2.state}")
      expect(page).to have_content("Zip Code: #{@app2.zip_code}")
      expect(page).to have_content("Description: #{@app2.description}")

      # save_and_open_page
      expect(page).to have_link(@pet1.name, href: "/pets/#{@pet1.id}")
      expect(page).to have_link(@pet3.name, href: "/pets/#{@pet3.id}")
      expect(page).to have_link(@pet6.name, href: "/pets/#{@pet6.id}")
      expect(page).to have_content(@petapp3.status)
      expect(page).to have_content(@petapp4.status)
      expect(page).to have_content(@petapp5.status)
    end

    it "shows a specific application" do
      visit "/applications/#{@app3.id}"

      expect(page).to have_content("Name: #{@app3.name}")
      expect(page).to have_content("Street Address: #{@app3.street_address}")
      expect(page).to have_content("City: #{@app3.city}")
      expect(page).to have_content("State: #{@app3.state}")
      expect(page).to have_content("Zip Code: #{@app3.zip_code}")
      expect(page).to have_content("Description: #{@app3.description}")

      # save_and_open_page
      expect(page).to have_link(@pet5.name, href: "/pets/#{@pet5.id}")
      expect(page).to have_content(@petapp6.status)
    end
  end
end