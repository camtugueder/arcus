class SessionsController < ApplicationController
  before_action :authenticate_token!, only: :destroy

  def create
    student = Student.find_by!(email: params[:email])

    if student.authenticate(params[:password])
      token = SecureRandom.hex
      student.update_columns(token: token)

      render json: { token: token }
    else
      render json: { errors: [ { detail: "Invalid email or password" }]}, status: :unprocessable_entity
    end
  end

  def destroy
    resource = current_user
    resource.update_columns(token: nil)
    session[:current_user_token] = nil

    head :ok
  end
end
