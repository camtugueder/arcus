# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_after_action :verify_authorized, only: [:create, :destroy]

  respond_to :json

  private
  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "logged out successfully"
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
