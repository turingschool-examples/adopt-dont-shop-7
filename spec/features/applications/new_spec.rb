require "rails_helper"

RSpec.describe "application new" do
  describe 'US 2' do
    describe 'US 2 PT2 ' do
      let!(:app1) {Application.create!(name: "Odell", street_address: "123 Dog Lane", city: "Denver", state: "Colorado", zip_code: 70890, description: "Practicing for when I have kids", status: "In Progress")}
      let!(:shelter1) {Shelter.create!({foster_program: true, name: "Martin's Shelter", city: "Denver", rank: 5})}
      let!(:pet1) {app1.pets.create!(adoptable: false, age: 10, breed:"Huski", name: "Billy", shelter_id: shelter1.id)}
      it 'fills out the application form' do
        
        
        visit "/applications/new"

        fill_in :name, with: "Bob"
        fill_in :street_address, with: "3455 DR"
        fill_in :city, with: "LA"
        fill_in :state, with: "Cali"
        fill_in :zip_code, with: 34567
        fill_in :description, with: "I'm here"

        click_on("Submit")
        # save_and_open_page 

        expect(page).to have_content('Bob')
        expect(page).to have_content('3455 DR')
        expect(page).to have_content(34567)

        expect(page).to have_content("In Progress")

      end
    end
  end
end
