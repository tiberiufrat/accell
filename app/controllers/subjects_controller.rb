class SubjectsController < ApplicationController
  before_action :set_subject, only: %i[ show edit update destroy ]

  def index
    @search = Subject.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @subjects = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @subject
  end

  def new
    @subject = Subject.new
  end

  def edit
  end

  def create
    @subject = Subject.new(subject_params)
    @subject.save!

    respond_to do |format|
      format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @subject.update!(subject_params)
    respond_to do |format|
      format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_subject
      @subject = Subject.find(params[:id])
    end

    def subject_params
      params.require(:subject).permit(:title, :color, :icon, :staff_only, :individual_activity, :attendance, :evaluation)
    end
end
