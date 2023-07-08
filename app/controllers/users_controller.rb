class UsersController < ApplicationController
    def create
      user = User.new(user_params)
      if user.save
        session[:user_id] = user.id
        render json: user
      else
        render json: { error: 'Failed to create user' }, status: :unprocessable_entity
      end
    end
  
    def show
      if logged_in?
        render json: current_user
      else
        render json: { error: 'Not authorized' }, status: :unauthorized
      end
    end
  
    private
  
    def user_params
      params.permit(:username, :password, :password_confirmation)
    end
  end
  