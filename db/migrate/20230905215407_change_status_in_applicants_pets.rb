class ChangeStatusInApplicantsPets < ActiveRecord::Migration[7.0]
  def change
    change_column_default :applicants_pets, :status, from: nil, to: "Pending"
  end
end
