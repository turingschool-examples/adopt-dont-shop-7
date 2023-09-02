class RenamePetsApplicantsToPetApplicants < ActiveRecord::Migration[7.0]
  def change
    rename_table :pets_applicants, :pet_applicants
  end
end
