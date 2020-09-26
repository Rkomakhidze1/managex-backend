class AddCompanyIdColumnToProjectsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :company_id, :int
  end
end
