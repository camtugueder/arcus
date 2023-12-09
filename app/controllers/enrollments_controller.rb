class EnrollmentsController < ApplicationController
  def create
    @enrollment = Enrollment.new(enrollment_params)
    @enrollment.student_id = current_user.id

    @enrollment.save
  end

  def enrollment_params
    params.require(:enrollment).permit(:course_id)
  end
end
