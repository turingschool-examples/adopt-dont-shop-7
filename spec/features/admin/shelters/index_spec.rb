require "rails_helper"

RSpec.describe "the admin shelters index page" do
	before(:each) do
		@shelter1 = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    @shelter2 = Shelter.create!(name: "Fred and Daphne's Super Shelter", city: "Irvine CA", foster_program: false, rank: 10)
    @shelter3 = Shelter.create!(name: "Velma's Pet Emporium", city: "Irvine CA", foster_program: false, rank: 7)
    @pet1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter1.id)
    @pet2 = Pet.create!(name: "Scrappy", age: 1, breed: "Not So Great Dane", adoptable: true, shelter_id: @shelter2.id)
    @pet3 = Pet.create!(name: "Blue", age: 3, breed: "Blue Dog", adoptable: true, shelter_id: @shelter1.id)
    @app1 = Application.create!(name: "Shaggy",
																street_address: "1234 Bobs rd",
																city: "Denver",
																state: "Colorado",
																zip_code: "80220",
																description: "I want a dog!",
																status: "Pending")
    @app2 = Application.create!(name: "Fred",
																street_address: "1234 Fred rd",
																city: "Boulder",
																state: "Colorado",
																zip_code: "80221",
																description: "I NEED a dog!",
																status: "Pending")
    PetApplication.create!(application: @app1, pet: @pet1)
    PetApplication.create!(application: @app2, pet: @pet2) 
	end

	# User Story 10
  it "shows all the shelters in descending alphabetical order" do
    visit '/admin/shelters'
    
		within("#shelters") do
			expect(@shelter3.name).to appear_before(@shelter1.name)
			expect(@shelter3.name).to appear_before(@shelter2.name)
			expect(@shelter1.name).to appear_before(@shelter2.name)
        
			expect(page).to have_content("Fred and Daphne's Super Shelter")
			expect(page).to have_content("Mystery Building")
			expect(page).to have_content("Velma's Pet Emporium") 
		end
  end

  # User Story 11
  it "has a section for Shelters with pending applications" do
    visit '/admin/shelters'
        
    within("#pending_apps") do
      expect(page).to have_content(@shelter1.name)
      expect(page).to have_content(@shelter2.name)
      expect(page).to_not have_content(@shelter3.name)
    end
  end
end