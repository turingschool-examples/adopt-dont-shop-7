class DropApplicantsPets < ActiveRecord::Migration[7.0]
  def up
    drop_table :applicants_pets
  end

  def down
    create_table :applicant_pets, id: false do |t|
      t.bigint :applicant_id
      t.bigint :pet_id
    end
  end
end
