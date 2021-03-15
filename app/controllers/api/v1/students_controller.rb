class Api::V1::StudentsController < Api::V1::BaseController
  def index
    if params[:family_id]
      @students = Student.where(family_id: params[:family_id])
    elsif params[:form_id]
      @students = Student.where(form_id: params[:form_id])
    elsif params[:school_id]
      @students = Student.where(school_id: params[:school_id])
    else
      @students = Student.all
    end

    render(json: @students)
  end

  def show
    @student = Student.find(params[:id])

    render(json: @student.to_json)
  end
end