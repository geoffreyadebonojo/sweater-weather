class Api::V1::UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save && validation
      render json: {data:
        {
          message: "Successfully created! Here's your key",
          key: user.api_key
        }
      }, status: 201
    else
      render json: {message: "problem occured!"}, status: 400
    end

  end

  private

  def validation
    params[:password] == params[:password_confirmation]
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

end
