class StudentsController < ApplicationController
  def index
    @students = Student.order(:created_at).page(params[:page]).per(params[:per_page] || 10)
  end

  def show
    @student = Student.find(params[:id])
  end

  def create
    @student = Student.new(student_params)

    process_and_render_response(@student) { |student| student.save }
  end

  def update
    @student = student.find(params[:id])

    process_and_render_response(@student){ |student| student.update(student_params) }
  end

  def destroy
    @student = Student.find(params[:id])

    process_and_render_response(@student){ |student| student.destroy }
  end

  def student_params
    params.require(:student).permit(:name, :email)
  end
end