require "rails_helper"

RSpec.describe "Application Show Page" do
  before(:each) do
    @application_1 = Application.create(name: "John")
    @shelter = Shelter.create()
    @dog = @shelter.pets.create(name: "Dog")
    @cat = @shelter.pets.create(name: "Cat")
  end

  it "has application details" do

    visit "/applications/:id"
#  When I visit an applications show page
#  Then I can see the following:
    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.full_address) #instance method to put together address
    expect(page).to have_content(@application_1.description)
    expect(page).to have_link("#{@dog.name}") #instance method to query application_pets
    expect(page).to have_link("#{@cat.name}")
    expect(page).to have_content(@application_1.status)

    click_link("#{@dog.name}")

    expect(page.current_path).to eq("/pets/#{@dog.id}")

    visit "/applications/:id"
    click_link("#{@cat.name}")

    expect(page.current_path).to eq("/pets/#{@cat.id}")
  end
end
