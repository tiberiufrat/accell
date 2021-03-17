class Api::V1::StaffsController < Api::V1::BaseController
  def index
    if params[:school_id]
      @staffs = Staff.has_school School.find(params[:school_id])
    elsif params[:form_id]
      @staffs = Classroom.find(params[:form_id]).form_tutor
    else
      @staffs = Staff.all
    end

    render :index, formats: :json
  end

  def show
    @staff = Staff.find(params[:id])

    render :show, formats: :json
  end
end