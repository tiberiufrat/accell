class GradebooksController < ApplicationController

  def index
  end

  def show_classroom
    @classroom = Classroom.find(params[:classroom_id])
    @students = @classroom.all_students.sort_by &:name
    @subjects = @students.map {|s| s.subjects}.flatten.uniq.sort_by &:title
  end

end
