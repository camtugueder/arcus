class TeachersController < ApplicationController
  def index
    @teachers = Teacher.order(:created_at)
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def create
    @teacher = Teacher.new(teacher_params)

    process_and_render_response(@teacher) { |teacher| teacher.save }
  end

  def update
    @teacher = Teacher.find(params[:id])

    process_and_render_response(@teacher) { |teacher| teacher.update(teacher_params) }
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    process_and_render_response(@teacher) { |teacher| teacher.destroy }
  end

  def teacher_params
    params.require(:teacher).permit(:name)
  end
end