require 'rails_helper'

RSpec.describe CoursesController, type: :request do

  let(:teacher) { create(:user, :teacher) }
  let(:course) { create(:course, teacher: teacher) }

  before { sign_in teacher }

  describe 'GET /courses' do
    before do
      create_list(:course, 10)
      get courses_path, as: :json
    end

    it 'returns all courses' do
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(10)
    end
  end

  describe 'GET /courses/:id' do
    context 'when the course exists' do
      it 'returns the course' do
        get course_path(course), as: :json
        expect(response).to have_http_status(:ok)
        expect(json['name']).to eq(course.name)
      end
    end

    context 'when the course does not exist' do
      it 'returns a not found response' do
        get course_path(id: -1), as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /courses' do
    let(:course_params) { { course: { name: 'New Course', teacher_id: teacher.id } } }

    it 'creates a new course' do
      expect {
        post courses_path, params: course_params, as: :json
      }.to change(Course, :count).by(1)
                                 .and change { teacher.reload.taught_courses.count }.by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT /courses/:id' do
    let(:update_params) { { course: { name: 'Updated Course Name' } } }

    it 'updates the course' do
      put course_path(course), params: update_params, as: :json
      expect(response).to have_http_status(:ok)
      expect(course.reload.name).to eq('Updated Course Name')
    end
  end

  describe 'DELETE /courses/:id' do
    it 'deletes the course' do
      delete course_path(course), as: :json
      expect(response).to have_http_status(:ok)
      expect(Course.exists?(course.id)).to be false
    end
  end

  it_behaves_like 'standard error handling', '/courses.json'
end