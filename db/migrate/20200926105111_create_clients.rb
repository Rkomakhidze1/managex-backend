class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :surname
      t.string :id_number
      t.string :phone_number
      t.integer :company_id

      t.timestamps
    end
  end
end
