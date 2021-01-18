class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show edit update destroy ]

  def index
    @search = Activity.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @activities = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @activity
  end

  def new
    @activity = Activity.new
  end

  def edit
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.save!

    respond_to do |format|
      format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @activity.update!(activity_params)
    respond_to do |format|
      format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      params.require(:activity).permit(:all_day, :start, :end, :days_of_week, :start_time, :end_time, :start_recur, :end_recur, :title, :description, :description_staff_only, :creator_id, :coordinator_id, :subject_id)
    end
end
