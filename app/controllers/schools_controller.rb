class SchoolsController < ApplicationController
  before_action :set_school, only: %i[ show edit update destroy ]

  def index
    @search = School.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @schools = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @school
  end

  def new
    @school = School.new
  end

  def edit
  end

  def create
    @school = School.new(school_params)
    @school.save!

    respond_to do |format|
      format.html { redirect_to @school, notice: 'School was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @school.update!(school_params)
    respond_to do |format|
      format.html { redirect_to @school, notice: 'School was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @school.destroy
    respond_to do |format|
      format.html { redirect_to schools_url, notice: 'School was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_school
      @school = School.find(params[:id])
    end

    def school_params
      params.require(:school).permit(:name, :email, :phone, :country, :city, :address)
    end
end
