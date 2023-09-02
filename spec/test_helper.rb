def load_test_data 
  @shelter_1 = Shelter.create!(name: 'Duck Pond', city: "Denver", rank: 5, foster_program: true)
  @shelter_2 = Shelter.create!(name: 'Bear Den', city: "Fort Collins", rank: 3, foster_program: false)
  @shelter_3 = Shelter.create!(name: 'Flamingo Flamboyance', city: "San Francisco", rank: 3, foster_program: false)
  @shelter_4 = Shelter.create!(name: 'Koala Colony', city: "Sydney", rank: 4, foster_program: false)
  @shelter_5 = Shelter.create!(name: 'Dog Park', city: "Paris", rank: 3, foster_program: true)
  @shelter_6 = Shelter.create!(name: 'Cat Cafe', city: "Amsterdam", rank: 2, foster_program: true)
  
  @drake = @shelter_1.pets.create!(name: 'Drake', breed: "pit bull", age: 6, adoptable: true)
  @bill = @shelter_1.pets.create!(name: 'Bill', breed: "jack russell terrier", age: 5, adoptable: false )
  
  @beardo = @shelter_2.pets.create!(name: 'Beardo', breed: "schnauzer", age: 6, adoptable: true )
  @megan = @shelter_2.pets.create!(name: 'Megan', breed: "golden doodle", age: 1, adoptable: false)
  
  @flora = @shelter_3.pets.create!(name: 'Flora', breed: "samoyed", age: 6, adoptable: false )
  @phoebe = @shelter_3.pets.create!(name: 'Phoebe', breed: "chihuahua", age: 2, adoptable: false)
  
  @yuka = @shelter_4.pets.create!(name: 'Yuka', breed: "great dane", age: 4, adoptable: true)
  @gonzo = @shelter_4.pets.create!(name: 'Gonzo', breed: "lab", age: 1, adoptable: false)
  
  @cherry = @shelter_5.pets.create!(name: 'Cherry', breed: "german shepard", age: 4, adoptable: true)
  @portia = @shelter_5.pets.create!(name: 'Portia', breed: "chow chow", age: 1, adoptable: false)
  
  @stinky = @shelter_6.pets.create!(name: 'Stinky', breed: "australian shepard", age: 1, adoptable: false)
  @bob = @shelter_6.pets.create!(name: 'Bob', breed: "blue heeler", age: 1, adoptable: false)

  @applicant1 = Applicant.create!(name: "P Sherman", street_address: "42 Wallaby Way", city: "Sydney", state: "NSW", zipcode: "2307", description: "best pet parent duh")
end
