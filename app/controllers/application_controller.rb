class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Pundit::Authorization
  before_action :authenticate_user!
  after_action :verify_authorized

  rescue_from ActiveRecord::RecordNotFound,
              Pundit::NotAuthorizedError,
              StandardError, with: :handle_exceptions

  def not_found
    render json: { error: "Not found" }, status: :not_found
  end

  private

  def handle_exceptions(exception)
    case exception
    when ActiveRecord::RecordNotFound
      error_response(exception.message, :not_found)
    when Pundit::NotAuthorizedError
      error_response('You are not authorized to perform this action.', :forbidden)
    else
      error_response(exception.message, :internal_server_error)
    end
  end

  def error_response(message, status)
    render json: { error: message }, status: status unless performed?
  end
end