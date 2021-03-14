class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show edit update destroy ]

  def index
    if params[:activityable_gid]
      activityable = GlobalID::Locator.locate(params[:activityable_gid])
      @activities = case activityable.class.to_s
      when 'Student'
        puts 'Student!'
        Activity.where(activityable: activityable) + Activity.where(activityable: activityable.form) + Activity.where(activityable: activityable.form.school)
      when 'Classroom'
        puts 'Classroom!'
        Activity.where(activityable: activityable) + Activity.where(activityable: activityable.school)
      else
        puts 'Otherwise!'
        Activity.where(activityable: activityable)
      end

    elsif params[:qdate] && params[:qweekday] && params[:qsubject] && params[:qstudent]
      student = Student.find(params[:qstudent])

      unique_activity = Activity.one_time.where(subject_id: params[:qsubject]).select {|a| a.start.to_date.iso8601 == params[:qdate] && student.has_activity_own_or_inherited?(a) }

      recurring_activity = Activity.recurring.where(subject_id: params[:qsubject]).select {|a| a.start_recur.iso8601 < params[:qdate] && (a.end_recur ? a.end_recur.iso8601 > params[:qdate] : true) && a.days_of_week.include?(params[:qweekday]) && student.has_activity_own_or_inherited?(a) }

      @activities = unique_activity + recurring_activity

      # if @activities.empty?
      #   @activities = Activity.where(subject_id: params[:qsubject])
      # end
        
    else
      @activities = Activity.where(activityable: School.first)
    end

    respond_to do |format|
      format.any(:html, :json) { @activities }
      format.csv { render csv: @activities }
      format.js
    end
  end

  def show
    fresh_when etag: @activity
  end

  def new
    @activity = Activity.new
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.save!

    respond_to do |format|
      format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
      format.json { render :show, status: :created }
      format.js
    end
  end

  def update
    @activity.update!(activity_params)
    respond_to do |format|
      format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
      format.json { render :show }
      format.js
    end
  end

  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      params.require(:activity).permit(:all_day, :start, :end, :start_time, :end_time, :start_recur, :end_recur, :title, :description, :description_staff_only, :creator_id, :coordinator_id, :subject_id, :activityable_gid, days_of_week: [])
    end

    def ajax_params
      {
        all_day: params[:activity][:all_day]
      }
    end
end
