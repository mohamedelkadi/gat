# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  attr_reader :current_user
  # Token token="auth_token" , email="user@test.com"
  def authenticate!
    unless request.headers.include?('HTTP_AUTHORIZATION')
      render json: { message: 'Authentication failed' }, status: 401
      return
    end

    authenticate_with_http_token do |token, options|
      unless options[:email].presence
        render json: { message: 'Authentication failed' }, status: 401
        return
      end

      email = options[:email]
      user = User.find_by(email: email, authentication_token: token)

      if user.nil?
        render json: { message: 'Authentication failed' }, status: 401
        return
      end

      @current_user = user
    end

    render json: { message: 'Authentication failed' }, status: 401 unless @current_user
  end

  # Rescues
  rescue_from ActiveRecord::RecordNotFound do
    render json: { message: 'Not found' }, status: 404
  end
end
