class Api::V1::ClassroomsController < Api::V1::BaseController
  def index
    if params[:school_id]
      @classrooms = Classroom.where(school_id: params[:school_id])
    else
      @classrooms = Classroom.all
    end

    render(json: @classrooms)
  end

  def show
    @classroom = Classroom.find(params[:id])

    render(json: @classroom.to_json)
  end
end