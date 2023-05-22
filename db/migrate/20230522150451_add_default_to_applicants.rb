class AddDefaultToApplicants < ActiveRecord::Migration[7.0]
  def change
    change_column_default :applicants, :application_status, "In Progress"
  end
end
