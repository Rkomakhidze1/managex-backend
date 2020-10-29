class V1::ClientsController < ApplicationController

    def get
        clients = Client.where company_id: schedule_params[:company_id]
        render json:{success: true, clients: clients}, status: :ok
    end

    def pay
        client = Client.find schedule_params[:client_id]
        updated_schedule = update_payment_schedule client.payment_schedule, BigDecimal(schedule_params[:payment])
        already_paid = client.full_payment - sum(updated_schedule)
        client.already_paid = already_paid
        has_to_pay = client.full_payment - client.already_paid
        client.has_to_pay = has_to_pay
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
