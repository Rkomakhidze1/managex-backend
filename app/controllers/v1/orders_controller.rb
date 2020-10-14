class V1::OrdersController < ApplicationController
    # before_action :authorized
        
    def create
        client = Client.new client_params
        client.company_id = @user.company_id
        client.save

        apartment_price_sum = 0
        parking_price_sum = 0

        if order_params[:apartment_ids]
        apartments = Apartment.find order_params[:apartment_ids] 
        apartments.map! do |apart|
            apart.reserved = true 
            apart
        end
        apartment_price_sum = apartments.reduce(0) {|sum, obj| sum + obj.price}
        apartment_space_sum = apartments.reduce(0) {|sum, obj| sum + obj.space}
        end

        if order_params[:parking_ids]
        parkings = Parking.find order_params[:parking_ids]
        parkings.map! do |park|
            park.reserved = true 
            park
        end 
        parking_price_sum = parkings.reduce(0) {|sum, obj| sum + obj.price}
        parking_space_sum = parkings.reduce(0) {|sum, obj| sum + obj.space}
        end

        order = Order.new order_params
        order.client_id = client.id
        order.user_id = @user.id
        order.apartment_price_sum = apartment_price_sum
        order.apartment_space_sum = apartment_space_sum
        order.parking_price_sum = parking_price_sum
        order.parking_space_sum = parking_space_sum
        order.full_price_sum = apartment_price_sum + parking_price_sum
        order.save
        render json: {order: order}, status: :created
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
            apartment_ids: [],
            parking_ids: []
        )
    end

    def client_params
        params.permit(:name, :surname, :phone_number, :id_number)
    end
end

