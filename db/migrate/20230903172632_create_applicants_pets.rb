class CreateApplicantsPets < ActiveRecord::Migration[7.0]
  def change
    create_table :applicants_pets do |t|
      t.references :applicant, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end