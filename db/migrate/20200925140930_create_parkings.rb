class CreateParkings < ActiveRecord::Migration[6.0]
  def change
    create_table :parkings do |t|
      t.integer :block
      t.integer :number
      t.integer :space
      t.integer :price
      t.boolean :is_sold
      t.boolean :reserved
      t.integer :project_id

      t.timestamps
    end
  end
end
