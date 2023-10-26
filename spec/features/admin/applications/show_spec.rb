require 'rails_helper' 

RSpec.describe "Application Show Page" do 
  before(:each) do 
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @application1 = Application.create(name: "John", street_address: "123 makebelieve dr.", city: "fakesville", state: "NA", zip_code: 12345, description: "I need a companion!", status: "In Progress")
    @application2 = Application.create(name: "Sally", street_address: "333 Not Real Pl.", city: "Pleasentville", state: "PO", zip_code: 12345, description: "I need a companion!", status: "In Progress")
    @application3 = Application.create(name: "Jack Skellington", street_address: "Ooky Spooky Lane", city: "Halloweentown", state: "PO", zip_code: 12345, description: "I love pets!", status: "In Progress")

    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
    @pet_4 = @shelter_1.pets.create(name: "Mr. Bond", breed: "tabby", age: 3, adoptable: true)

    @pet_app_1 = PetApplication.create!(application_id: "#{@application1.id}", pet_id: "#{@pet_1.id}", status: "Pending")
    @pet_app_2 = PetApplication.create!(application_id: "#{@application2.id}", pet_id: "#{@pet_2.id}", status: "Pending")
    @pet_app_3 = PetApplication.create!(application_id: "#{@application2.id}", pet_id: "#{@pet_3.id}", status: "Pending")
    @pet_app_4 = PetApplication.create!(application_id: "#{@application3.id}", pet_id: "#{@pet_1.id}", status: "Pending")

  end

  describe "visiting the admin/application show page" do 
    it "shows the applicant and all the applicants details" do 
      visit "/admin/applications/#{@application1.id}"

      expect(page).to have_content("Name: #{@application1.name}")
      expect(page).to have_content("Street Address: #{@application1.street_address}")
      expect(page).to have_content("#{@application1.city}")
      expect(page).to have_content("#{@application1.state}")
      expect(page).to have_content("#{@application1.zip_code}")
      expect(page).to have_content("Why I would make a good home: #{@application1.description}")
      expect(page).to have_content("Applying to Adopt:" )
      expect(page).to have_content("Status: #{@application1.status}")
    end

    it "shows every pet that the application is for and
    buttons to Approve or Reject the adoption" do
      visit "/admin/applications/#{@application1.id}"
      # 

      within("#pet_applied_for-#{@pet_1.id}") do
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_button("Approve Application")
        expect(page).to have_button("Reject Application")
      end
    end

    it "when the 'Approve Application' button is clicked, it
    updates the application to show that pet is approved" do
      visit "/admin/applications/#{@application2.id}"

      within("#pet_applied_for-#{@pet_2.id}") do
        click_button("Approve Application")
        expect(page).to have_current_path("/admin/applications/#{@application2.id}")
        expect(page).to have_content(@pet_2.name)
        expect(page).to have_content("#{@pet_2.name}\nPet Status: Approved")
      end

      within("#pet_applied_for-#{@pet_3.id}") do
        expect(page).to have_current_path("/admin/applications/#{@application2.id}")
        expect(page).to have_content(@pet_3.name)
        expect(page).to have_content("Pet Status: Pending" )
      end

    end

    it "when the 'Reject Application' button is clicked, it
    updates the application to show that pet is rejected :(" do
      visit "/admin/applications/#{@application2.id}"

      within("#pet_applied_for-#{@pet_2.id}") do
        click_button("Reject Application")
        expect(page).to have_current_path("/admin/applications/#{@application2.id}")
        expect(page).to have_content(@pet_2.name)
        expect(page).to have_content("#{@pet_2.name}\nPet Status: Rejected")
      end

      within("#pet_applied_for-#{@pet_3.id}") do
        expect(page).to have_current_path("/admin/applications/#{@application2.id}")
        expect(page).to have_content(@pet_3.name)
        expect(page).to have_content("Pet Status: Pending" )
      end
    end

    it "shows that an application for a specific pet marked 'Approved'
    does not show the pet as 'Approved on another application for that
    pet" do
      visit "/admin/applications/#{@application1.id}"
      # 

      within("#pet_applied_for-#{@pet_1.id}") do
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_button("Approve Application")
        expect(page).to have_button("Reject Application")
        click_button("Approve Application")
        expect(page).to have_content("#{@pet_1.name}\nPet Status: Approved")
      end

      visit "/admin/applications/#{@application3.id}"

      within("#pet_applied_for-#{@pet_1.id}") do
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_button("Approve Application")
        expect(page).to have_button("Reject Application")
      end
    end
  end
end