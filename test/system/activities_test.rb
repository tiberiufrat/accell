require "application_system_test_case"

class ActivitiesTest < ApplicationSystemTestCase
  setup do
    @activity = activities(:one)
  end

  test "visiting the index" do
    visit activities_url
    assert_selector "h1", text: "Activities"
  end

  test "creating a Activity" do
    visit activities_url
    click_on "New Activity"

    check_label "activity_all_day" if @activity.all_day
    fill_in "Coordinator", with: @activity.coordinator_id
    fill_in "Creator", with: @activity.creator_id
    fill_in "Days of week", with: @activity.days_of_week
    fill_in "Description", with: @activity.description
    fill_in "Description staff only", with: @activity.description_staff_only
    fill_in "End", with: @activity.end
    fill_in "End recur", with: @activity.end_recur
    fill_in "End time", with: @activity.end_time
    fill_in "Start", with: @activity.start
    fill_in "Start recur", with: @activity.start_recur
    fill_in "Start time", with: @activity.start_time
    fill_in "Subject", with: @activity.subject_id
    fill_in "Title", with: @activity.title
    click_on "Create Activity"

    assert_text "Activity was successfully created."
    click_on "Back"
  end

  test "updating a Activity" do
    visit activities_url
    click_on "Edit it", match: :first

    check_label "activity_all_day" if @activity.all_day
    fill_in "Coordinator", with: @activity.coordinator_id
    fill_in "Creator", with: @activity.creator_id
    fill_in "Days of week", with: @activity.days_of_week
    fill_in "Description", with: @activity.description
    fill_in "Description staff only", with: @activity.description_staff_only
    fill_in "End", with: @activity.end
    fill_in "End recur", with: @activity.end_recur
    fill_in "End time", with: @activity.end_time
    fill_in "Start", with: @activity.start
    fill_in "Start recur", with: @activity.start_recur
    fill_in "Start time", with: @activity.start_time
    fill_in "Subject", with: @activity.subject_id
    fill_in "Title", with: @activity.title
    click_on "Update Activity"

    assert_text "Activity was successfully updated."
    click_on "Back"
  end

  test "destroying a Activity" do
    visit activities_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Activity was successfully destroyed."
  end
end
