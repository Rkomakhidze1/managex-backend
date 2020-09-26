class AddProjectIdColumnToOrdersTable < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :project_id, :int
  end
end
