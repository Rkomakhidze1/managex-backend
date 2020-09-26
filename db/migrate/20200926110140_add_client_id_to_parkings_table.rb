class AddClientIdToParkingsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :parkings, :client_id, :int
  end
end
