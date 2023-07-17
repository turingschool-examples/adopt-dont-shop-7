class CreateJoinTableApplicantsPets < ActiveRecord::Migration[7.0]
  def change
    create_join_table :applicants, :pets do |t|
      # t.index [:applicant_id, :pet_id]
      # t.index [:pet_id, :applicant_id]
    end
  end
end
