require "rails_helper"

RSpec.describe "The Admin Application Show Page" do
  before(:each) do
    @shelter = Shelter.create(
      name: "Aurora shelter", 
      city: "Aurora, CO",
      foster_program: false, 
      rank: 9
    )
      
    @pet_1 = Pet.create!(
      adoptable: true,
      age: 1,
      breed: "sphynx",
      name: "Lucille Bald",
      shelter_id: @shelter.id
    )
    @pet_2 = Pet.create!(
      adoptable: true,
      age: 3,
      breed: "doberman",
      name: "Lobster",
      shelter_id: @shelter.id
    )
    @pet_3 = Pet.create!(
      adoptable: false,
      age: 2,
      breed: "saint bernard",
      name: "Beethoven",
      shelter_id: @shelter.id
    )
            
    @application = Application.create!(
      name: 'Jared Wlrd',
      description: 'I want more furry friends.',
      street_address: '6543 House Lane',
      city: 'Atlanta',
      state: 'GA',
      zip_code: 62003,
      status: "Pending",
      pets: [@pet_2, @pet_3]
    )
  end
            
  describe "User Story 13" do
    it "can reject a pet appliction" do
      visit "/admin/applications/#{@application.id}"

      expect(page).to have_content("Lobster")
      expect(page).to have_content("Beethoven")

      expect(page).to have_content("Pending")
      within "#pet_#{@pet_2.id}_buttons" do 
        expect(page).to have_button("Reject")
        click_on "Reject"
      end
      expect(current_path).to eq("/admin/applications/#{@application.id}")

      within "#pet_#{@pet_2.id}_buttons" do 
        expect(page).to_not have_button("Approve")
        expect(page).to_not have_button("Reject")
        expect(page).to have_content("Rejected")
      end

      within "#pet_#{@pet_3.id}_buttons" do 
        expect(page).to have_button("Approve")
        expect(page).to have_button("Reject")
        expect(page).to_not have_content("Rejected")
      end
    end
  end

  describe "User Story 12" do
    it "can approve a pet appliction" do
      visit "/admin/applications/#{@application.id}"

      expect(page).to have_content("Lobster")
      expect(page).to have_content("Beethoven")

      expect(page).to have_content("Pending")
      within "#pet_#{@pet_2.id}_buttons" do 
        expect(page).to have_button("Approve")
        click_on "Approve"
      end
      expect(current_path).to eq("/admin/applications/#{@application.id}")

      within "#pet_#{@pet_2.id}_buttons" do 
        expect(page).to_not have_button("Approve")
        expect(page).to_not have_button("Reject")
        expect(page).to have_content("Approved")
      end

      within "#pet_#{@pet_3.id}_buttons" do 
        expect(page).to have_button("Approve")
        expect(page).to have_button("Reject")
        expect(page).to_not have_content("Approved")
      end
    end
  end

  describe "User Story 14" do
    it "Approved/Rejected Pets on one Application do not affect other Applications" do
      application_2 = Application.create!(
        name: 'Billy Bob',
        description: 'I am cool.',
        street_address: '8943 jose way',
        city: 'LA',
        state: 'CA',
        zip_code: 11903,
        status: "Pending",
        pets: [@pet_2, @pet_3]
      )
    
      visit "/admin/applications/#{@application.id}"

      within "#pet_#{@pet_2.id}_buttons" do 
        expect(page).to have_button("Reject")
        click_on "Reject"

        expect(page).to_not have_button("Approve")
        expect(page).to_not have_button("Reject")
        expect(page).to have_content("Rejected")
      end

      visit "/admin/applications/#{application_2.id}"

      within "#pet_#{@pet_2.id}_buttons" do
        expect(page).to have_button("Approve")
        expect(page).to have_button("Reject")
        expect(page).to_not have_content("Rejected")
      end
    end
  end
end