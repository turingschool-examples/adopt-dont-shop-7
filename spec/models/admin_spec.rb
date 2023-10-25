require "rails_helper"

RSpec.describe Admin, type: :model do
  
  describe 'method test' do
    before :each do
      @shelter1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      @shelter2 = Shelter.create(name: "Denver shelter", city: "Denver, CO", foster_program: true, rank: 10)
      @shelter3 = Shelter.create(name: "Boulder shelter", city: "Boulder, CO", foster_program: false, rank: 8)
      @app1 = App.create(name: "Timmy", address: "123 Main St", city: "Aurora", state: "CO", zip: 80111, description: "I love dogs")
      @pet2 = @shelter1.pets.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster")
      @pet3 = @shelter2.pets.create(adoptable: true, age: 2, breed: "saint bernard", name: "Beethoven")
    end

    it "lists all the shelters in the system in reverse alphabetical order" do
      expect(Shelter.order_by_name_reverse).to eq([@shelter2, @shelter3, @shelter1])
    end
  end
end