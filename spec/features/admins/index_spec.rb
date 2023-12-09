require "rails_helper"

RSpec.describe "the admins shelter index" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @turing = Shelter.create(foster_program: true, name: "Turing", city: "Backend", rank: 3)
    @fsa = Shelter.create(foster_program: true, name: "Fullstack Academy", city: "Backend", rank: 3)
    @codesmith = Shelter.create(foster_program: true, name: "Codesmith", city: "Backend", rank: 3)
    @rithm = Shelter.create(foster_program: true, name: "Rithm School", city: "Backend", rank: 3)
    @hackreactor = Shelter.create(foster_program: true, name: "Hack Reactor", city: "Backend", rank: 3)
  end

  it "lists shelters in reverse alphabetical order by name" do
    # User Story 10
    visit "/admin/shelters"
    save_and_open_page
    expect("Turing").to appear_before("Rithm School")
    expect("Rithm School").to appear_before("Hack Reactor")
    expect("Hack Reactor").to appear_before("Fullstack Academy")
    expect("Fullstack Academy").to appear_before("Codesmith")
  end
end
