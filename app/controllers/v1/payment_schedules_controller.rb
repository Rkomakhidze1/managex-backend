class V1::PaymentSchedulesController < ApplicationController
    def create
        date = Date.parse(params[:start_date])
        schedule = IceCube::Schedule.new(date)
        schedule.add_recurrence_rule IceCube::Rule.monthly.day_of_month(date.day)
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
        drop_num = 12 - client.payment_schedule.length
        payment_schedule = client.payment_schedules.first
        schedule = IceCube::Schedule.from_hash(payment_schedule.schedule)
        raw_schedule = schedule.first 12 
        show = raw_schedule.drop drop_num
        render json: {success: true, schedule: show}
    end
end
