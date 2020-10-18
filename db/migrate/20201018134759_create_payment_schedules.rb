class CreatePaymentSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_schedules do |t|
      t.json :schedule, default: {}
      t.integer :client_id

      t.timestamps
    end
  end
end
