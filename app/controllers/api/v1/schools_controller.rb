class Api::V1::SchoolsController < Api::V1::BaseController
  def index

  end
  
  def show
    school = School.find(params[:id])

    render(json: school.to_json)
  end
end