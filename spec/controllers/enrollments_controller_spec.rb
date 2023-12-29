require 'rails_helper'

RSpec.describe EnrollmentsController, type: :request do
  let(:student) { create(:user, :student) }
  let(:course) { create(:course) }

  before { sign_in student }

  describe 'POST /enrollments' do
    context 'with valid parameters' do
      let(:enrollment_params) { { enrollment: { course_id: course.id } } }

      it 'creates a new enrollment' do
        expect {
          post enrollments_path, params: enrollment_params, as: :json
        }.to change(Enrollment, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { enrollment: { course_id: nil } } }

      it 'does not create an enrollment' do
        expect {
          post enrollments_path, params: invalid_params, as: :json
        }.not_to change(Enrollment, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
