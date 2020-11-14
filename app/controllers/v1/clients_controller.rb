class V1::ClientsController < ApplicationController

    def get
        clients = Client.where project_id: schedule_params[:project_id]
        render json:{success: true, clients: clients}, status: :ok
    end

    def show_payments_monthly
        clients = Client.all
        payments_json = clients.map {|c| c.payment_dates} 
        payments = payments_json.map {|p| p.map {|d| JSON.parse d}}
        monthly_statistics = []
        12.times do |i|
            month_arr = payments.map do |arr|
                arr.filter {|p| p.keys[0].split("-")[1].to_i == (i + 1)}
            end
            if month_arr.include? [] && month_arr.uniq.size <= 1
                monthly_statistics.push 0
                next
            end
            months = []
            month_arr.map {|a| a.map {|i| months.push i}}
            decimal_arr = months.map {|item| BigDecimal(item.values()[0])}
            sum = sum(decimal_arr)
            monthly_statistics.push sum
        end 
        render json:{success: true, monthly: monthly_statistics}, status: :ok
    end

    def show_payments_daily
        clients = Client.all
        payments_json = clients.map {|c| c.payment_dates} 
        payments = payments_json.map {|p| p.map {|d| JSON.parse d}}
        daily_statistics = []
        month_arr = payments.map do |arr|
            arr.filter {|p| p.keys[0].split("-")[1].to_i == (params[:month])}
        end
        # byebug
        month = []
        month_arr.map {|a| a.map {|b| month.push b}}
        first = month.filter {|p| p.keys()[0].split("-")[2].to_i.between?(1, 5)} 
        second = month.filter {|p| p.keys()[0].split("-")[2].to_i.between?(6, 10)}
        third = month.filter {|p| p.keys()[0].split("-")[2].to_i.between?(11, 15)}
        fourth = month.filter {|p| p.keys()[0].split("-")[2].to_i.between?(16, 20)}
        fifth = month.filter {|p| p.keys()[0].split("-")[2].to_i.between?(21, 25)}
        sixth = month.filter {|p| p.keys()[0].split("-")[2].to_i.between?(25, 31)}
        arr = [
            first == [] ? 0 : sum(first.map {|a| BigDecimal(a.values()[0])}),
            second == [] ? 0 : sum(second.map {|a| BigDecimal(a.values()[0])}),
            third == [] ? 0 : sum(third.map {|a| BigDecimal(a.values()[0])}),
            fourth == [] ? 0 : sum(fourth.map {|a| BigDecimal(a.values()[0])}),
            fifth == [] ? 0 : sum(fifth.map {|a| BigDecimal(a.values()[0])}),
            sixth == [] ? 0 : sum(sixth.map {|a| BigDecimal(a.values()[0])}),
        ]
        render json:{success: true, daily: arr}, status: :ok 
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

        project = Project.find params[:project_id]
        project.already_paid += BigDecimal(schedule_params[:payment])
        project.save
        return render json: {success: false, message: err_msg(project)} if !project.save

        if client.save
            render json: {success: true, schedule: updated_schedule}, status: :ok
        else
            render json: {success: false, message: err_msg(client)}, status: :bad_request
        end
    end 

    private

    def schedule_params
        params.permit(:client_id, :payment, :project_id)
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
