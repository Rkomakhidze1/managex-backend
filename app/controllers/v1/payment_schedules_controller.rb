class V1::PaymentSchedulesController < ApplicationController
    def create
        # add column needed
        client = Client.find schedule_params[:client_id]
        amount_of_months = client.orders.first.payment_type.split(" ").last.to_i
        if client.payment_schedules.first
           return render json: {success: false, message: "client already has a schedule"}, status: :bad_request
        end
        monthly_payment = client.full_payment / BigDecimal(amount_of_months)
        client.payment_schedule = Array.new amount_of_months, monthly_payment 
        client.save
        if !client.save 
            render json: {success: false, message: client.errors.full_messages}
        end

        date = Date.parse(schedule_params[:start_date])
        schedule = IceCube::Schedule.new(date)
        schedule.add_recurrence_rule IceCube::Rule.monthly.day_of_month(date.day)
        hash_schedule = schedule.to_hash
        payment_schedule = PaymentSchedule.new schedule: hash_schedule, client_id: schedule_params[:client_id]
        if payment_schedule.save
            render json: {success: true, message: "schedule saved successfully"}
        else
            render json: {success: false, error: payment_schedule.errors.full_messages}
        end
    end

    def get
        client = Client.find schedule_params[:client_id]
        amount_of_months = client.orders.first.payment_type.split(" ").last.to_i
        if client.payment_schedules.empty?
            return render json: {success: false, message: "schedule does not exist"}, status: :bad_request
        end
        drop_num = amount_of_months - client.payment_schedule.length
        payment_schedule = client.payment_schedules.first
        schedule = IceCube::Schedule.from_hash(payment_schedule.schedule)
        raw_schedule = schedule.first amount_of_months 
        show = raw_schedule.drop drop_num
        show_with_payments = []
        show.count.times do |i|
           element = show[i].to_s + " -> " + client.payment_schedule[i].to_s
           show_with_payments.push element
        end
        render json: {success: true, schedule: show_with_payments}
    end

    private

    def schedule_params
        params.permit(:start_date, :client_id, :number_of_months)
    end
end
