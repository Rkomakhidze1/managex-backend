class ChangePaymentScheduleArrayToFloats < ActiveRecord::Migration[6.0]
  def change
    change_column :clients, :payment_schedule, :decimal, precision: 8, scale: 2, default: [], array: true
  end
end
