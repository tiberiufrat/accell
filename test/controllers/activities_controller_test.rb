require "test_helper"

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activity = activities(:one)
  end

  test "should get index" do
    get activities_url
    assert_response :success
  end

  test "should get new" do
    get new_activity_url
    assert_response :success
  end

  test "should create activity" do
    assert_difference('Activity.count') do
      post activities_url, params: { activity: { all_day: @activity.all_day, coordinator_id: @activity.coordinator_id, creator_id: @activity.creator_id, days_of_week: @activity.days_of_week, description: @activity.description, description_staff_only: @activity.description_staff_only, end: @activity.end, end_recur: @activity.end_recur, end_time: @activity.end_time, start: @activity.start, start_recur: @activity.start_recur, start_time: @activity.start_time, subject_id: @activity.subject_id, title: @activity.title } }
    end

    assert_redirected_to activity_url(Activity.last)
  end

  test "should show activity" do
    get activity_url(@activity)
    assert_response :success
  end

  test "should get edit" do
    get edit_activity_url(@activity)
    assert_response :success
  end

  test "should update activity" do
    patch activity_url(@activity), params: { activity: { all_day: @activity.all_day, coordinator_id: @activity.coordinator_id, creator_id: @activity.creator_id, days_of_week: @activity.days_of_week, description: @activity.description, description_staff_only: @activity.description_staff_only, end: @activity.end, end_recur: @activity.end_recur, end_time: @activity.end_time, start: @activity.start, start_recur: @activity.start_recur, start_time: @activity.start_time, subject_id: @activity.subject_id, title: @activity.title } }
    assert_redirected_to activity_url(@activity)
  end

  test "should destroy activity" do
    assert_difference('Activity.count', -1) do
      delete activity_url(@activity)
    end

    assert_redirected_to activities_url
  end
end
