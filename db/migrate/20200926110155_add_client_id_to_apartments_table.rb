class AddClientIdToApartmentsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :apartments, :client_id, :int
  end
end
