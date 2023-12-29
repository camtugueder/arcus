
require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let(:user) { create(:user) }
  let(:authorized_headers) { { 'Authorization': "Bearer #{token}" } }
  let(:token) { response.headers['Authorization'].split.last }

  describe 'JWT token functionality' do
    before do
      post user_session_path, params: { user: { email: user.email, password: user.password } }, as: :json
    end

    it 'allows access with a valid token' do
      get courses_path, headers: authorized_headers, as: :json
      expect(response).to have_http_status(:success)
    end

    it 'revokes the token on logout' do
      # Simulate user logout which should revoke the token
      delete destroy_user_session_path, headers: authorized_headers, as: :json

      # Verify that the token is revoked
      get courses_path, headers: authorized_headers, as: :json
      expect(response).to have_http_status(:unauthorized)
    end

  end

  # Edge cases:

  describe 'edge cases' do
    it 'denies access without a token' do
      get courses_path, as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it 'denies access with a malformed token' do
      get courses_path, headers: { 'Authorization': "Bearer malformed_token" }, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
