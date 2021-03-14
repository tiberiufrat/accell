class AttendancesController < ApplicationController
    before_action :set_attendance, only: %i[ show edit update destroy ]

  def index
    @search = Attendance.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @attendances = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @attendance
  end

  def new
    @attendance = Attendance.new
  end

  def edit
  end

  def create
    @attendance = Attendance.new(attendance_params)
    @attendance.save!

    respond_to do |format|
      format.html { redirect_to @attendance, notice: 'Attendance was successfully created.' }
      format.json { render :show, status: :created }
      format.js
    end
  end

  def update
    @attendance.update!(attendance_params)
    respond_to do |format|
      format.html { redirect_to attendances_path, notice: 'Attendance was successfully updated.' }
      format.json { render :show }
      format.js
    end
  end

  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    def attendance_params
      params.require(:attendance).permit(:student_id, :activity_id, :date, :presence)
    end
end
