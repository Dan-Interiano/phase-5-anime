class UsersController < ApplicationController
    wrap_parameters format: []
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def show
        current_user = User.find(session[:user_id])
        render json: current_user
    end
    def create 
        user = User.create!(user_params)
        session[:user_id] = user.id 
        render json: user, status: :created  
    end 

    private     

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
