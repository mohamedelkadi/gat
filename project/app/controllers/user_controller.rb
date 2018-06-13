class UserController < ApplicationController
  before_action :authenticate!, only: :sign_out

  def sign_in
    @user = User.find_by_email(user_params[:email])

    unless @user && @user.valid_password?(user_params[:password])
      warden.custom_failure!
      return render json: { message: 'The email or password you entered is incorrect' }, status: 401
    end

    render json: { email: @user.email,
                   token: @user.authentication_token }
  end

  def sign_up
    @user = User.new user_params
    if @user.save
      render json: { email: @user.email,
                     token: @user.authentication_token }
    else
      render json: { erros: @user.errors.messages }, status: :unprocessable_entity
    end

  rescue ActiveRecord::RecordNotUnique
    render json: { error: 'user with this email already exist' }, status: :unprocessable_entity
  end

  def sign_out
    current_user.reset_authentication_token
    current_user.save!
    @current_user = nil
    render json: {}
  end

  private

  def user_params
    params.require('user').permit(:email, :password)
  end
end