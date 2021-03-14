class UserActivitiesController < ApplicationController
  before_action :set_user

  def index
    @current_day = (Date.parse(params[:date]) if params[:date]) || Date.today
    if @user.is_staff?
      @activities = Activity.where(coordinator_id: @user.profile.id) + Activity.where(activityable: @user.profile.current_school)

      @user.profile.classrooms.each do |classroom| 
        Activity.where(activityable: classroom).each do |activity|
          unless @activities.include? activity
            @activities << activity
          end
        end
      end
      
      @activities.select! do |activity|
        (activity.start && activity.start.to_date == @current_day) || (activity.days_of_week.include?(@current_day.wday.to_s) && activity.start_recur <= @current_day && (activity.end_recur.nil? || activity.end_recur >= @current_day))
      end
      
      @activities.sort_by! do |activity|
        if activity.start
          activity.start.iso8601
        else
          @current_day.iso8601 + 'T' + activity.start_time + ':00+02:00'
        end
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
