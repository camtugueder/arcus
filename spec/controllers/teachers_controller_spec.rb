require 'rails_helper'

RSpec.describe TeachersController, type: :request do
  let(:teacher) { create(:user, :teacher) }
  let(:admin) { create(:user, :admin) }

  before { sign_in admin }

  describe 'GET /teachers' do
    before do
      create_list(:user, 10, :teacher)
      get teachers_path, as: :json
    end

    it 'returns all teachers' do
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(10)
    end
  end

  describe 'GET /teachers/:id' do
    it 'returns the teacher' do
      get teacher_path(teacher), as: :json
      expect(response).to have_http_status(:ok)
      expect(json['name']).to eq(teacher.name)
    end
  end

  describe 'POST /teachers' do
    let(:teacher_params) { { teacher: { name: 'New Teacher', email: 'teacher@example.com', password: 'password', password_confirmation: 'password' } } }

    it 'creates a new teacher' do
      expect {
        post teachers_path, params: teacher_params, as: :json
      }.to change(User, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT /teachers/:id' do
    let(:update_params) { { teacher: { name: 'Updated Name' } } }

    it 'updates the teacher' do
      put teacher_path(teacher), params: update_params, as: :json
      expect(response).to have_http_status(:ok)
      expect(teacher.reload.name).to eq('Updated Name')
    end
  end

  describe 'DELETE /teachers/:id' do
    it 'deletes the teacher' do
      delete teacher_path(teacher), as: :json
      expect(response).to have_http_status(:ok)
      expect(User.exists?(teacher.id)).to be false
    end
  end

  it_behaves_like 'standard error handling', '/teachers.json'
end
