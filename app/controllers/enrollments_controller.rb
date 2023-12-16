class EnrollmentsController < ApplicationController
  before_action :authorize_enrollment

  def create
    @enrollment = Enrollment.new(enrollment_params)
    @enrollment.student_id = current_user.id

    if @enrollment.save
      render json: @enrollment, status: :created
    else
      render json: @enrollment.errors, status: :unprocessable_entity
    end
  end

  private

  def authorize_enrollment
    authorize Enrollment
  end
  def enrollment_params
    params.require(:enrollment).permit(:course_id)
  end
end
