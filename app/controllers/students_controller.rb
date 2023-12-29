class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :update, :destroy]
  before_action :authorize_student

  def index
    @students = User.with_role(:student).order(:created_at).page(params[:page]).per(params[:per_page] || 10)
  end

  def show
  end

  def create
    @student = User.new(student_params)
    @student.add_role(:student)
    if @student.save
      render :show, status: :created, location: student_url(@student)
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  def update
    if @student.update(student_params)
      render :show, status: :ok, location: student_url(@student)
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @student.destroy
      render json: { success: 'Student deleted successfully!' }, status: :ok
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  private

  def authorize_student
    if @student
      authorize @student, policy_class: StudentPolicy
    else
      authorize :student, policy_class: StudentPolicy
    end
  end

  def set_student
    @student = User.with_role(:student).find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :email, :password, :password_confirmation)
  end
end