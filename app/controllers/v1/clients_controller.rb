class V1::ClientsController < ApplicationController

    def get
        client = Client.find schedule_params[:client_id]
        render json:{success: true, client: client}, status: :ok
    end

    def pay
        client = Client.find schedule_params[:client_id]
        updated_schedule = update_payment_schedule client.payment_schedule, schedule_params[:payment]
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
        params.permit(:client_id, :payment)
    end

    def update_payment_schedule(current_schedule, payment)
        return [] if current_schedule == []

        val = current_schedule.first - payment
        if (val == 0) 
            updated_schedule = current_schedule.drop 1
            updated_schedule
        elsif(val < 0)
            updated_schedule = current_schedule.drop 1
            update_payment_schedule(updated_schedule, val.abs)
        else
            current_schedule[0] = val
            current_schedule
        end
    end

    def sum(arr)
        arr.reduce(0) { |sum, n| sum + n }
    end
end