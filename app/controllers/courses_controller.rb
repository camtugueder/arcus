class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :update, :destroy]
  before_action :authorize_course
  def index
    @courses = Course.order(:created_at).page(params[:page]).per(params[:per_page])
    @user_courses = current_user.courses.pluck(:id)
  end

  def show
    render json: { error: 'Course not found!' }, status: :not_found unless @course
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      render json: { success: 'Course created successfully!' }, status: :created
    else
      render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @course.update(course_params)
      render json: { success: 'Course updated successfully!' }, status: :ok
    else
      render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @course.destroy
      render json: { success: 'Course deleted successfully!' }, status: :ok
    else
      render json: { error: 'An error occurred while deleting the course' }, status: :unprocessable_entity
    end
  end

  private

  def authorize_course
    authorize Course
  end
  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :teacher_id)
  end
end