class V1::OrdersController < ApplicationController
    # before_action :authorized
        
    def create
        apartment_price_sum = BigDecimal("0")
        parking_price_sum = BigDecimal("0")

        if order_params[:apartment_ids]
            apartment_ids_arr = order_params[:apartment_ids].split(",") 
            apartments = Apartment.find apartment_ids_arr
            apartments.map! do |apart|
                apart.reserved = true 
                apart.save
                apart
            end
            apartments
            apartment_price_sum = apartments.reduce(0) {|sum, apart| sum + apart.price}
            apartment_space_sum = apartments.reduce(0) {|sum, apart| sum + apart.space}
        end
        if order_params[:parking_ids]
            parking_ids_arr = order_params[:parking_ids].split(",")
            parkings = Parking.find parking_ids_arr
            parkings.map! do |park|
                park.reserved = true 
                park.save
                park
            end 
            parkings
            parking_price_sum = parkings.reduce(0) {|sum, park| sum + park.price}
            parking_space_sum = parkings.reduce(0) {|sum, park| sum + park.space}
        end

        client = Client.new client_params
        client.full_payment = apartment_price_sum + parking_price_sum;
        client.has_to_pay = apartment_price_sum + parking_price_sum;
        client.already_paid = BigDecimal("0")
        client.save
        if !client.save
            return render json: {success: false, message:  err_msg(client)}, status: :bad_request
        end
        
        order = Order.new order_params
        order.client_id = client.id
        order.user_id = @user.id
        order.apartment_price_sum = apartment_price_sum
        order.apartment_space_sum = apartment_space_sum
        order.parking_price_sum = parking_price_sum
        order.parking_space_sum = parking_space_sum
        order.full_price_sum = apartment_price_sum + parking_price_sum
        if order.save
            render json: {order: order}, status: :created
        else
            render json: {success: false, message: err_msg(order)}, status: :bad_request
        end
    end
    
    def get
        project = Project.find order_params[:project_id]
        orders = project.orders
        render json: {success: true, orders: orders}, status: :ok
    end


    private

    def order_params
        params
        .permit(
            :contract_start_date, 
            :contract_end_date, 
            :payment_type, 
            :in_advance_payment, 
            :project_id,
            :apartment_ids,
            :parking_ids
        )
    end

    def client_params
        params.permit(:name, :surname, :phone_number, :id_number, :project_id)
    end
end

