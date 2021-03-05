class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  # REGISTER
  def create
    @user_in_db = User.find_by(email: params[:email])

    if @user_in_db
      render json: { error: "Email already used" }, status: :bad_request
    else
      @user = User.create(user_params)
      if @user.valid?
        token = encode_token({ user_id: @user.id })
        render json: { id: @user.id, email: @user.email, token: token }
      else
        render json: { error: "Invalid email or password" }, status: :bad_request
      end
    end
  end

  # LOG IN
  def login
    @user = User.find_by(email: params[:email])
    
    if @user && @user.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { id: @user.id, email: @user.email, token: token }
    else
      render json: { error: "Email or password is wrong" }, status: :bad_request
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
