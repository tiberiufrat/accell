json.extract! activity, :id, :title, :description, :description_staff_only, :creator_id, :coordinator_id, :subject_id, :created_at, :updated_at

json.start activity.start if activity.start
json.end activity.end if activity.end
json.allDay activity.all_day

if activity.subject
  json.backgroundColor activity.subject.html_color
  json.borderColor activity.subject.html_color
  json.textColor 'var(--dark)' if activity.subject.color == 'yellow'
end

if activity.start_recur
  json.daysOfWeek activity.days_of_week
  json.startTime activity.start_time
  json.endTime activity.end_time
  json.startRecur activity.start_recur
  json.endRecur activity.end_recur
  json.groupId activity.title
end

json.activityable_gid activity.activityable.to_global_id.uri if activity.activityable

json.activityableName activity.activityable.name if activity.activityable
json.subjectName activity.subject.title if activity.subject
json.coordinatorName activity.coordinator.name if activity.coordinator
json.subjectIcon activity.subject.fa_icon if activity.subject

json.url activity_url(activity, format: :html)

json.update_url activity_url(activity, method: :patch)

json.edit_url edit_activity_path(activity)