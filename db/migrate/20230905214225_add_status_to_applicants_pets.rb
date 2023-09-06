class AddStatusToApplicantsPets < ActiveRecord::Migration[7.0]
  def change
    add_column :applicants_pets, :status, :string
  end
end
