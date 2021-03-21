class Api::V1::ActivitiesController < Api::V1::BaseController
  def index
    if params[:activityable_gid]
      activityable = GlobalID::Locator.locate(params[:activityable_gid])
      @activities = case activityable.class.to_s
      when 'Student'
        Activity.where(activityable: activityable) + Activity.where(activityable: activityable.form) + Activity.where(activityable: activityable.form.school)
      when 'Classroom'
        Activity.where(activityable: activityable) + Activity.where(activityable: activityable.school)
      else
        Activity.where(activityable: activityable)
      end

    elsif params[:qdate] && params[:qweekday] && params[:qsubject] && params[:qstudent]
      student = Student.find(params[:qstudent])

      unique_activity = Activity.one_time.where(subject_id: params[:qsubject]).select {|a| a.start.to_date.iso8601 == params[:qdate] && student.has_activity_own_or_inherited?(a) }

      recurring_activity = Activity.recurring.where(subject_id: params[:qsubject]).select {|a| a.start_recur.iso8601 < params[:qdate] && (a.end_recur ? a.end_recur.iso8601 > params[:qdate] : true) && a.days_of_week.include?(params[:qweekday]) && student.has_activity_own_or_inherited?(a) }

      @activities = unique_activity + recurring_activity
        
    else
      @activities = nil
    end

    render :index, formats: :json
  end

  def show
    @activity = Activity.find(params[:id])

    render :show, formats: :json
  end
end