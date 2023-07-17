class CreateApplicantsPets < ActiveRecord::Migration[6.0]
  def change
    create_table :applicants_pets do |t|
      t.bigint :pet_id
      t.bigint :applicant_id
      t.timestamps
    end

    add_foreign_key :applicants_pets, :pets, column: :pet_id
    add_foreign_key :applicants_pets, :applicants, column: :applicant_id
  end
end
