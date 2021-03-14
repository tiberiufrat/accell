class MarksController < ApplicationController
  before_action :set_mark, only: %i[ show edit update destroy ]

  def index
    @search = Mark.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @marks = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @mark
  end

  def new
    @mark = Mark.new
  end

  def edit
  end

  def create
    @mark = Mark.new(mark_params)
    @mark.save!

    respond_to do |format|
      format.html { redirect_to (@mark.student.form.present? ? gradebook_classroom_path(@mark.student.form) : gradebook_path ), notice: 'Mark was successfully created.' }
      format.json { render :show, status: :created }
      format.js
    end
  end

  def update
    @mark.update!(mark_params)
    respond_to do |format|
      format.html { redirect_to marks_path, notice: 'Mark was successfully updated.' }
      format.json { render :show }
      format.js
    end
  end

  def destroy
    @mark.destroy
    respond_to do |format|
      format.html { redirect_to marks_url, notice: 'Mark was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    def set_mark
      @mark = Mark.find(params[:id])
    end

    def mark_params
      params.require(:mark).permit(:student_id, :activity_id, :staff_id, :date, :grade)
    end
end
