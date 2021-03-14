json.extract! subject, :id, :title, :color, :icon, :staff_only, :individual_activity, :attendance, :evaluation, :created_at, :updated_at
json.url subject_url(subject, format: :json)

if params[:student_id]
  student = Student.find(params[:student_id])
  json.days_of_week_recurring subject.activities.recurring.select {|a| a.activityable == student || a.activityable == student.form || student.classrooms.include?(a.activityable) }.pluck(:days_of_week).flatten.uniq

  json.unique_dates subject.activities.one_time.select {|a| a.activityable == student || a.activityable == student.form || student.classrooms.include?(a.activityable) }.pluck(:start).uniq.map(&:to_date).map(&:iso8601)

else
  json.days_of_week_recurring subject.activities.recurring.pluck(:days_of_week).flatten.uniq
  json.unique_dates subject.activities.one_time.pluck(:start).uniq.map(&:to_date).map(&:iso8601)

end
