class InstructorsController < ApplicationController

  #TODO build out instructors and create a relation
  def index
    @students = Student.all
    @students.each do |student|
      puts student.time_zone
    end
  end

end
