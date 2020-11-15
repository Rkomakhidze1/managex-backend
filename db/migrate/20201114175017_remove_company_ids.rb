class RemoveCompanyIds < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :company_id
  end
end
