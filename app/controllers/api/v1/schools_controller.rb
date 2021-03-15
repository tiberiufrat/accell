class Api::V1::SchoolsController < Api::V1::BaseController
  def index
    render(json: School.all)
  end

  def show
    school = School.find(params[:id])

    render(json: school.to_json)
  end
end