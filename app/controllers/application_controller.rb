class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_token!
  helper_method :current_user

  def current_user
    Student.find_by!(token: session[:current_user_token])
  end

  private

  def authenticate_user!
    (current_user or render_unauthorized)
  end

  def authenticate_token!
    render_unauthorized if !request.headers['Authorization'].present?
    authenticate_with_http_token do |token, options|
      return render_unauthorized if token.nil?
      student = Student.find_by(token: token)
      return render_unauthorized if student.nil?
      session[:current_user_token] = student.token
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: exception.message.to_json, status: :not_found
  end

  def render_unauthorized
    render json: { message: 'Bad credentials' }, status: :unauthorized
  end

  def process_and_render_response(resource)
    if yield resource
      render json: resource, status: :ok
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end
end
