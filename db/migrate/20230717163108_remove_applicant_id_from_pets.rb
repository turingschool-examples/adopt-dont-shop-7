class RemoveApplicantIdFromPets < ActiveRecord::Migration[7.0]
  def change
    remove_column :pets, :applicant_id, :integer
  end
end
