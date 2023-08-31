class FixForeignKeyName < ActiveRecord::Migration[7.0]
  def change
    rename_column :pets_applications, :applicants_id, :applicant_id
    rename_column :pets_applications, :pets_id, :pet_id
  end
end
