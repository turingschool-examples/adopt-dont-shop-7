require 'rails_helper'

RSpec.describe Application, type: :model do
 describe 'relationships' do
  it { should have_many :application_pets }
  it { should have_many(:pets).through(:application_pets)}
 end

 describe 'class methods' do
  it "returns a correct number of applications" do

    expect(Application.num_of_applications).to eq(3)

    @application_1 = Application.create!(name: "Selena", street_address: "123 Street", city: "City", state: "State", zip_code: "8888", adopting_reason: "Love for cats, no job", status:"Pending")
    @application_2 = Application.create!(name: "Laura", street_address: "58 Street", city: "City", state: "State", zip_code: "5555", adopting_reason: "Need company", status:"Rejected")
    @application_3 = Application.create!(name: "Isaac", street_address: "456 Street", city: "City", state: "State", zip_code: "78", adopting_reason: "Lots of love to give", status:"Accepted")

    expect(Application.num_of_applications).to eq(6)
  end
 end

 describe 'instance methods' do
  it "returns a populated address" do
    @application_1 = Application.create!(name: "Selena", street_address: "123 Street", city: "City", state: "State", zip_code: "8888", adopting_reason: "Love for cats, no job", status:"Pending")
    
    expect(@application_1.populate_address).to eq ("123 Street, City, State, 8888")
  end
 end
end