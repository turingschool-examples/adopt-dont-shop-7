require "rails_helper"

RSpec.describe "the admin application show" do
  before(:each) do
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Bare-y-Manilow", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 1, breed: "domestic shorthair", name: "Sylvester", shelter_id: @shelter_2.id)
    @pet_4 = Pet.create(adoptable: true, age: 1, breed: "orange tabby shorthair", name: "Lasagna", shelter_id: @shelter.id)
    @application_1 = Application.create!(name: "Peter Griffin", street: "200 Park Road", city: "Quahog", state: "MA", zip_code: "09876", description: "I like animals", status: "In Progress")
    @application_2 = Application.create!(name: "Quagmire", street: "300 Crest Lane", city: "Lowell", state: "NY", zip_code: "12345", description: "Giggity", status: "Pending")
    @apply_1 = PetApplication.create!(application_id: @application_1.id, pet_id: @pet_1.id, status: "Pending")
    @apply_2 = PetApplication.create!(application_id: @application_1.id, pet_id: @pet_2.id, status: "Pending")
  end

  describe "When I visit an admin application show page ('/admin/applications/:id')" do
    it "For every pet that the application is for, I see a button to approve the application for that specific pet" do

      visit "/admin/applications/#{@application_1.id}"

      within("#Bare-y-Manilow") do
        expect(page).to have_content(@pet_1.name) # Bare-y Manilow
        expect(page).to have_button("Approve")
      end

      within("#Lobster") do
        expect(page).to have_content(@pet_2.name) # Lobster
        expect(page).to have_button("Approve")
      end
    end

    it "When I click that button then I'm taken back to the admin application show page" do

      visit "/admin/applications/#{@application_1.id}"
      
      expect(page).to have_current_path("/admin/applications/#{@application_1.id}")
      # save_and_open_page
      within("#Bare-y-Manilow") do
        click_button("Approve")
        expect(page).to have_content("Approved")
        expect(page).to have_current_path("/admin/applications/#{@application_1.id}")
      end

      within("#Lobster") do
        expect(page).to_not have_content("Approved")
      end
    end

    it "For every pet that the application is for, I see a button to reject the application for that specific pet" do
      
      visit "/admin/applications/#{@application_1.id}"

      within("#Bare-y-Manilow") do
        expect(page).to have_content(@pet_1.name) # Bare-y Manilow
        expect(page).to have_button("Approve")
        expect(page).to have_button("Reject")
      end

      within("#Lobster") do
        expect(page).to have_content(@pet_2.name) # Lobster
        expect(page).to have_button("Approve")
        expect(page).to have_button("Reject")
      end
    end

    it "When I click the reject button then I'm taken back to the admin application show page and do not see buttons next to that pet" do

      visit "/admin/applications/#{@application_1.id}"
      
      expect(page).to have_current_path("/admin/applications/#{@application_1.id}")

      within("#Bare-y-Manilow") do
        click_button("Reject")
        expect(page).to have_content("Rejected")
        expect(page).to have_current_path("/admin/applications/#{@application_1.id}")
      end

      within("#Lobster") do
        expect(page).to_not have_content("Rejected")
      end
    end

    it "When I click assignment buttons they update the pet and then vanish from the view page" do

      visit "/admin/applications/#{@application_1.id}"
      
      within("#Bare-y-Manilow") do
        click_button("Reject")
        expect(page).to have_content("Rejected")
      end
      
      within("#Lobster") do
        click_button("Approve")
        expect(page).to have_content("Approved")
      end

      expect(page).to_not have_css('.button-group')
    end
  end
end
