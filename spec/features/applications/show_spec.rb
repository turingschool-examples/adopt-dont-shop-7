require "rails_helper"

RSpec.describe "the application show" do

  before :each do
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @application1 = Application.create!(name: "Mike", full_address: "9999 Street Road, Denver, CO 80231", description: "Gimme", status: "Pending")
    @application2 = Application.create!(name: "Eric", full_address: "888 Road Street, Salt Lake City, UT 88231", description: "5 solid meals a day", status: "Rejected")
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: @shelter.id)
    @application1.pets << @pet_1 
    @application1.pets << @pet_2 
    @application2.pets << @pet_2 
    @application2.pets << @pet_3 
  end

  it "shows the application and all it's attributes" do

    visit "/applications/#{@application1.id}"

    expect(page).to have_content(@application1.name)
    expect(page).to have_content(@application1.full_address)
    expect(page).to have_content(@application1.description)
    expect(page).to have_content(@application1.status)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)

  end

end
