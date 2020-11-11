class V1::ClientsController < ApplicationController

    def get
        clients = Client.where company_id: schedule_params[:company_id]
        render json:{success: true, clients: clients}, status: :ok
    end

    def pay
        date = Time.now.to_s
        today = date.split()[0]

        client = Client.find schedule_params[:client_id]
        updated_schedule = update_payment_schedule client.payment_schedule, BigDecimal(schedule_params[:payment])
        payment_date_hash = {today => schedule_params[:payment]}
        client.payment_dates.push payment_date_hash.to_json 
        client.already_paid = client.full_payment - sum(updated_schedule)
        client.has_to_pay = client.full_payment - client.already_paid
        client.payment_schedule = updated_schedule

        if client.save
            render json: {success: true, schedule: updated_schedule}
        else
            render json: {success: false, data: client.errors.full_messages}
        end
    end 

    private

    def schedule_params
        params.permit(:client_id, :payment, :company_id)
    end

    def update_payment_schedule(current_schedule, payment)
        return [payment] if current_schedule == []

        val = current_schedule.first - payment
        if (val.round(2) == 0) 
            updated_schedule = current_schedule.drop 1
            updated_schedule
        elsif(val.round(2) < 0)
            updated_schedule = current_schedule.drop 1
            update_payment_schedule(updated_schedule, val.round(2).abs)
        else
            current_schedule[0] = val.round(2)
            current_schedule
        end
    end

    def sum(arr)
        arr.reduce(0) { |sum, n| sum + n }
    end
end
