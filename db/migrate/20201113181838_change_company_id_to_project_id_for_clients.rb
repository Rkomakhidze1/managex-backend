class ChangeCompanyIdToProjectIdForClients < ActiveRecord::Migration[6.0]
  def change
    rename_column :clients, :company_id, :project_id
  end
end
