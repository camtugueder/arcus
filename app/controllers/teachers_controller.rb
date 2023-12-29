class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :update, :destroy]
  before_action :authorize_teacher

  def index
    @teachers = User.with_role(:teacher).order(:created_at)
  end

  def show
  end

  def create
    @teacher = User.new(teacher_params)
    @teacher.add_role(:teacher)

    if @teacher.save
      render :show, status: :created
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  def update
    if @teacher.update(teacher_params)
      render :show
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @teacher.destroy
      render json: { success: 'Teacher deleted successfully!' }, status: :ok
    else
      render json: { error: "Teacher could not be deleted" }, status: :unprocessable_entity
    end
  end

  private

  def authorize_teacher
    if @teacher
      authorize @teacher, policy_class: TeacherPolicy
    else
      authorize :teacher, policy_class: TeacherPolicy
    end
  end

  def set_teacher
    @teacher = User.with_role(:teacher).find(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:name, :email, :password, :password_confirmation)
  end
end