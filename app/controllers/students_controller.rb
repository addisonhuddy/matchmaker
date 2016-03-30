class StudentsController < ApplicationController
  def index
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      flash[:success] = "Working on finding you the optimal group"
      redirect_to @student
    else
      render 'index'
    end

  end

  def show
    @student = Student.find(params[:id])
  end

  private

  def student_params
    params.require(:student).permit(:name,
                                    :time_zone,
                                    :gatech_class,
                                    :gatechuname,
                                    :gatechid,
                                    :email,
                                    :learning_objectives,
                                    :preferred_tools,
                                    :myers_briggs,
                                    :week_preferred,
                                    :weekend_preferred,
                                    :java_expertise)
  end
end
