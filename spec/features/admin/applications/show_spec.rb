require "rails_helper"

RSpec.feature "the admin application show" do
  describe 'when visiting /admin/applications/:id' do
    scenario 'US12 displays a button to approve pet for adoption' do
      application2 = Application.create(applicant_name: "Benjamin Franklin", street_address: "456 Main St.", city: "Boston", state: "MA", zip_code: "12345", description: "I like turkeys", status: "Pending")
      shelter1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet1 = shelter1.pets.create(name: "Zeus", breed: "Great Dane", age: 3, adoptable: true)
      pet2 = shelter1.pets.create(name: "Demeter", breed: "Golden Retriever", age: 4, adoptable: true)
      application2.pets << pet1
      application2.pets << pet2

      visit "/admin/applications/#{application2.id}"

      expect(page).to have_button('Adopt', count: 2)
    end
  end
end
