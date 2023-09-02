class CreatePetsApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :pets_applicants do |t|
      t.references :pet, foreign_key: true
      t.references :applicant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
