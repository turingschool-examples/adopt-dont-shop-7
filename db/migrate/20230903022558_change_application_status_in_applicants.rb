class ChangeApplicationStatusInApplicants < ActiveRecord::Migration[7.0]
  def change
    change_column :applicants, :application_status, :string, default: 'In Progress'
  end
end
