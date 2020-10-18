class V1::PaymentSchedulesController < ApplicationController
    def create
        schedule = IceCube::Schedule.new(now = Time.now)
        schedule.add_recurrence_rule IceCube::Rule.monthly.day_of_month(params[:day])
        hash_schedule = schedule.to_hash
        payment_schedule = PaymentSchedule.new schedule: hash_schedule, client_id: params[:client_id]
        if payment_schedule.save
            render json: {success: true}
        else
            render json: {success: false, error: payment_schedule.errors.full_messages}
        end
    end

    def get
        client = Client.find params[:client_id]
        payment_schedule = client.payment_schedules.first
        schedule = IceCube::Schedule.from_hash(payment_schedule.schedule)
        show = schedule.first 12
        render json: {success: true, schedule: show}
    end
end
