require "rails_helper"

RSpec.feature "the admin application show" do
  describe 'when visiting /admin/applications/:id' do
    before :each do 
      application2 = Application.create(applicant_name: "Benjamin Franklin", street_address: "456 Main St.", city: "Boston", state: "MA", zip_code: "12345", description: "I like turkeys", status: "Pending")
      application3 = Application.create(applicant_name: "Alexander Hamilton", street_address: "789 Main St.", city: "Boston", state: "MA", zip_code: "12345", description: "I'm smart af", status: "In Progress")   
      
      shelter1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet1 = shelter1.pets.create(name: "Zeus", breed: "Great Dane", age: 3, adoptable: true)
      pet2 = shelter1.pets.create(name: "Demeter", breed: "Golden Retriever", age: 4, adoptable: true)
      
      application2.pets << pet1
      application2.pets << pet2
      application3.pets << pet1
      application3.pets << pet2
    end

    it 'US12 displays a button to approve a pet for adoption' do
      visit "/admin/applications/#{application2.id}"

      expect(page).to have_button('Approve', count: 2)

      within("tr:contains('#{pet1.name}')") do
        click_button 'Approve'
      end

      expect(page).to have_current_path("/admin/applications/#{application2.id}")

      within("tr:contains('#{pet1.name}')") do
        expect(page).not_to have_button('Approve')
        expect(page).to have_content('APPROVED')
      end

      within("tr:contains('#{pet2.name}')") do
        expect(page).to have_button('Approve')
        expect(page).to_not have_content('APPROVED')
      end
    end

    it 'US13 displays a button to reject a pet for adoption' do
      visit "/admin/applications/#{application2.id}"

      expect(page).to have_button('Reject', count: 2)

      within("tr:contains('#{pet2.name}')") do
        click_button 'Reject'
      end

      expect(page).to have_current_path("/admin/applications/#{application2.id}")

      within("tr:contains('#{pet1.name}')") do
        expect(page).to have_button('Approve')
        expect(page).to have_button('Reject')
        expect(page).to have_content('Awaiting Approval')
      end

      within("tr:contains('#{pet2.name}')") do
        expect(page).to_not have_button('Reject')
        expect(page).to have_content('REJECTED')
        expect(page).to_not have_content('APPROVED')
      end
    end

    it 'US14 accepting or rejecting pets on one application does not affect others' do
      visit "/admin/applications/#{application2.id}"

      within("tr:contains('#{pet1.name}')") do
        click_button 'Approve'
      end

      within("tr:contains('#{pet2.name}')") do
        click_button 'Reject'
      end

      expect(application2.pet_applications.find_by(pet_id: pet1.id).approval).to be true
      expect(application3.pet_applications.find_by(pet_id: pet1.id).approval).to be nil
      expect(application3.pet_applications.find_by(pet_id: pet2.id).approval).to be nil

      visit "/admin/applications/#{application3.id}"

      within("tr:contains('#{pet2.name}')") do
        expect(page).to have_button('Approve')
        expect(page).to have_button('Reject')        
        expect(page).to have_content('Awaiting Approval')
      end
    end

    scenario 'US18 pets can only be approved for one application at a time' do
      visit "/admin/applications/#{application2.id}"

      within("tr:contains('#{pet1.name}')") do
        click_button 'Approve'
      end

      visit "/admin/applications/#{application3.id}"

      within("tr:contains('#{pet2.name}')") do
        expect(page).to have_button('Approve')
        expect(page).to have_button('Reject')
        expect(page).to have_content('Awaiting Approval')
      end
    end

    scenario 'US18 pets can only be approved for one application at a time' do
      visit "/admin/applications/#{application2.id}"

      within("tr:contains('#{pet1.name}')") do
        click_button 'Approve'
      end

      visit "/admin/applications/#{application3.id}"

      within("tr:contains('#{pet1.name}')") do
        expect(page).to have_button('Reject')
        expect(page).to have_content('APPROVED')
      end
    end
  end
end 