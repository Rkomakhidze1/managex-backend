class AddProjectIdToApartmentsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :apartments, :project_id, :int
  end
end
