class ChangeZipCodeToIntegerInApplicants < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      ALTER TABLE applicants
      ALTER COLUMN zip_code TYPE integer
      USING zip_code::integer
    SQL
  end

  def down
    change_column :applicants, :zip_code, :string
  end
end
