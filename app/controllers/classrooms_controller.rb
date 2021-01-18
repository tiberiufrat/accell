class ClassroomsController < ApplicationController
  before_action :set_classroom, only: %i[ show edit update destroy ]

  def index
    @search = Classroom.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @classrooms = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @classroom
  end

  def new
    @classroom = Classroom.new
  end

  def edit
  end

  def create
    @classroom = Classroom.new(classroom_params)
    @classroom.save!

    respond_to do |format|
      format.html { redirect_to @classroom, notice: 'Classroom was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @classroom.update!(classroom_params)
    respond_to do |format|
      format.html { redirect_to @classroom, notice: 'Classroom was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @classroom.destroy
    respond_to do |format|
      format.html { redirect_to classrooms_url, notice: 'Classroom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    def classroom_params
      params.require(:classroom).permit(:name, :optional, :color, :form_tutor_id, :allow_registration, :registration_code)
    end
end
