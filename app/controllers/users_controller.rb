class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  # REGISTER
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: { id: @user.id, email: @user.email, token: token }
    else
      render json: { error: "Invalid email or password" }
    end
  end

  # LOG IN
  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
    else
      render json: { error: "Email or password is wrong" }
    end
  end

  def auto_login
    render json: @user
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
