class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    #jwt token methods
    def encode_token(payload)
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end
    
    def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
    end

    def decoded_token
    if auth_header
        @token = auth_header.split(' ')[1]
        # header: { 'Authorization': 'Bearer <token>' }
        begin
        JWT.decode(@token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
        rescue JWT::DecodeError
        nil
        end
    end
    end

    def logged_in_user
    if decoded_token
        user_id = decoded_token[0]['user_id']
        @user = User.where("tokens @> ARRAY[?]::character varying[] AND id = ?", @token, user_id)[0]
    end
    end

    def logged_in?
    !!logged_in_user
    end

    def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end

    #error handlers
    private

    def not_found(e) 
        render json:{success: false, message: e}, status: :not_found
    end
end



