class AddAdoptionReasonToApplicantsPets < ActiveRecord::Migration[7.0]
  def change
    add_column :applicants_pets, :adoption_description, :text
  end
end
