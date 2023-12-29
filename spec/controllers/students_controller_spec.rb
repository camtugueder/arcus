require 'rails_helper'

RSpec.describe StudentsController, type: :request do
  let(:admin) { create(:user, :admin) }
  let(:student) { create(:user, :student)}

  before { sign_in admin }

  describe 'GET /students' do
    before do
      create_list(:user, 10, :student)
      get students_path, as: :json
    end

    it 'returns all students' do
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(10)
    end
  end

  describe 'GET /students/:id' do

    it 'returns the student' do
      get student_path(student), as: :json
      expect(response).to have_http_status(:ok)
      expect(json['name']).to eq(student.name)
    end
  end

  describe 'POST /students' do
    let(:student_params) { { student: { name: 'New Student', email: 'student@example.com', password: 'password', password_confirmation: 'password' } } }

    it 'creates a new student' do
      expect {
        post students_path, params: student_params, as: :json
      }.to change(User, :count).by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT /students/:id' do
    let(:update_params) { { student: { name: 'Updated Name' } } }

    it 'updates the student' do
      put student_path(student), params: update_params, as: :json
      expect(response).to have_http_status(:ok)
      expect(student.reload.name).to eq('Updated Name')
    end
  end

  describe 'DELETE /students/:id' do

    it 'deletes the student' do
      delete student_path(student), as: :json
      expect(response).to have_http_status(:ok)
      expect(User.exists?(student.id)).to be false
    end
  end

  it_behaves_like 'standard error handling', '/students.json'
end