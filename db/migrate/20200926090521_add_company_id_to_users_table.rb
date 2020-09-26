class AddCompanyIdToUsersTable < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :company_id, :int
  end
end
