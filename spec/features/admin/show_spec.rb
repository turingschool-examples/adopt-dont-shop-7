require "rails_helper"

RSpec.describe "admin application show page" do
  before(:each) do
    @shelter1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter2 = Shelter.create(name: "Denver shelter", city: "Denver, CO", foster_program: true, rank: 10)
    @shelter3 = Shelter.create(name: "Boulder shelter", city: "Boulder, CO", foster_program: false, rank: 8)
    @app1 = App.create(name: "Timmy", address: "123 Main St", city: "Aurora", state: "CO", zip: 80111, description: "I love dogs")
    @pet2 = @shelter1.pets.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster")
    @pet3 = @shelter2.pets.create(adoptable: true, age: 2, breed: "saint bernard", name: "Beethoven")
    @app1.pets << @pet2
  end

  it 'can approve applications for adoption' do

    # As a visitor
    # When I visit an admin application show page ('/admin/applications/:id')
    visit "/admin/apps/#{@app1.id}"
    
    # For every pet that the application is for, I see a button to approve the application for that specific pet
    expect(page).to have_button("approve application to adopt #{@pet2.name}")
    # When I click that button
    click_button("approve application to adopt #{@pet2.name}")
    # Then I'm taken back to the admin application show page
    expect(current_path).to eq("/admin/apps/#{@app1.id}")
    # And next to the pet that I approved, I do not see a button to approve this pet

    expect(page).to_not have_button("approve application to adopt #{@pet2}")
  
    # And instead I see an indicator next to the pet that they have been approved
    expect(page).to have_content("Approved!")
    expect(page).to_not have_content("Rejected!")
  end

  describe "rejecting applications" do
    it "can reject applications for adoption" do
      #       Rejecting a Pet for Adoption
      # As a visitor
      # When I visit an admin application show page ('/admin/applications/:id')
      visit "/admin/apps/#{@app1.id}"
      # For every pet that the application is for, I see a button to reject the application for that specific pet
      expect(page).to have_button("reject application to adopt #{@pet2.name}")
      # When I click that button
      click_button("reject application to adopt #{@pet2.name}")
      # Then I'm taken back to the admin application show page
      expect(current_path).to eq("/admin/apps/#{@app1.id}")
      # And next to the pet that I rejected, I do not see a button to approve or reject this pet
      expect(page).to_not have_button("reject application to adopt #{@pet2.name}")
      # And instead I see an indicator next to the pet that they have been rejected
      expect(page).to have_content("Rejected!")
      expect(page).to_not have_content("Approved!")
    end
  end
end