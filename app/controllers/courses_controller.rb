class CoursesController < ApplicationController
  before_action :authenticate_token!
  def index
    @courses = Course.order(:created_at).page(params[:page]).per(params[:per_page] || 10)
    @user_courses = Set.new(current_user.courses.pluck(:id)) if current_user
  end

  def show
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.new(course_params)

    process_and_render_response(@course) { |course| course.save }
  end

  def update
    @course = Course.find(params[:id])

    process_and_render_response(@course) { | course | course.update(course_params) }
  end

  def destroy
    @course = Course.find(params[:id])

    process_and_render_response(@course){ |course| course.destroy }
  end

  def course_params
    params.require(:course).permit(:name, :description, :teacher_id)
  end
end