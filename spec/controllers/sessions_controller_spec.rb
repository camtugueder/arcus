require 'rails_helper'

RSpec.describe SessionsController do
  before do
    format = Mime[:json]
    request.headers['Accept'] = "#{request.headers['Accept']},#{format}"
    request.headers['Content-Type'] = format.to_s
  end

  let(:user) { create(:student) }

  let(:session_params) {
    {
      email: user.email,
      password: '123456',
      format: :json
    }
  }

  describe 'POST #create' do
    it 'wrong credentials' do
      custom_params = session_params.clone
      custom_params[:password] = "wrong_password"

      post :create, params: custom_params

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'valid credentials return success' do
       post :create, params: session_params

       expect(response).to have_http_status(:success)

       body = JSON.parse(response.body)
       expect(body["token"]).not_to be_empty
    end
  end

  describe 'DELETE #destroy' do
    it 'destroy session' do
      user.update_columns(token: SecureRandom.hex)
      user.reload

      request.headers['Authorization'] = "Token token=#{user.token}"

      delete :destroy, params: { format: :json }, session: { current_user_token: user.token }

      expect(response).to have_http_status(:success)
      expect(user.reload.token).to be_nil
    end
  end
end