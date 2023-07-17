require 'rails_helper'

RSpec.describe 'the applicant shows page' do
  it 'shows the applicant and all its attributes' do
    @applicant1 = Applicant.create!(id: 1, name: 'Bob', street_address: '1234 a street', city: 'Irvine', state: 'CA',
                                    zip_code: '58200', status: 'In Progress', description: 'I love dogs')

    visit applicant_path(@applicant1)
    expect(page).to have_content(@applicant1.name)
  end

  # User Story 4 Test
  it 'can search for a pet by name' do
    @shelter1 = Shelter.create!(foster_program: true, name: 'Shelter 1', city: 'Irvine', rank: 1)
    @applicant1 = Applicant.create!(id: 1, name: 'Bob', street_address: '1234 a street', city: 'Irvine', state: 'CA',
                                    zip_code: '58200', status: 'In Progress', description: 'I love dogs')

    @pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter: @shelter1)

    @shelter1.pets << @pet1

    visit applicant_path(@applicant1)
    expect(find('form')).to have_content('Add a Pet to this Application')
    expect(find('form')).to have_content('Pet:')
    expect(find('form')).to have_selector('input[name="pet_name"]')

    fill_in 'pet_name', with: 'Lucille Bald'
    click_button 'submit'

    expect(current_path).to eq(applicant_path(@applicant1))
    expect(page).to have_content('Lucille Bald')
  end

  # User Story 5 Test
  it 'can add a pet to an application' do
    @shelter1 = Shelter.create!(foster_program: true, name: 'Shelter 1', city: 'Irvine', rank: 1)
    @applicant1 = Applicant.create!(id: 1, name: 'Bob', street_address: '1234 a street', city: 'Irvine', state: 'CA',
                                    zip_code: '58200', status: 'In Progress', description: 'I love dogs')

    @pet1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter: @shelter1)

    @shelter1.pets << @pet1

    visit applicant_path(@applicant1)
    fill_in 'pet_name', with: 'Lucille Bald'
    click_button 'submit'
    click_button 'Add Pet'

    # Looks for the pet name in the associated pets section
    associated_pets_heading = page.find('h3', text: 'Associated Pets')
    pet_name_paragraph = associated_pets_heading.sibling('p', text: 'Pet Name: Lucille Bald')
    expect(pet_name_paragraph).to be_present
  end
end
