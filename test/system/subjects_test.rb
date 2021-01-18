require "application_system_test_case"

class SubjectsTest < ApplicationSystemTestCase
  setup do
    @subject = subjects(:one)
  end

  test "visiting the index" do
    visit subjects_url
    assert_selector "h1", text: "Subjects"
  end

  test "creating a Subject" do
    visit subjects_url
    click_on "New Subject"

    check_label "subject_attendance" if @subject.attendance
    fill_in "Color", with: @subject.color
    fill_in "Evaluation", with: @subject.evaluation
    fill_in "Icon", with: @subject.icon
    check_label "subject_individual_activity" if @subject.individual_activity
    check_label "subject_staff_only" if @subject.staff_only
    fill_in "Title", with: @subject.title
    click_on "Create Subject"

    assert_text "Subject was successfully created."
    click_on "Back"
  end

  test "updating a Subject" do
    visit subjects_url
    click_on "Edit it", match: :first

    check_label "subject_attendance" if @subject.attendance
    fill_in "Color", with: @subject.color
    fill_in "Evaluation", with: @subject.evaluation
    fill_in "Icon", with: @subject.icon
    check_label "subject_individual_activity" if @subject.individual_activity
    check_label "subject_staff_only" if @subject.staff_only
    fill_in "Title", with: @subject.title
    click_on "Update Subject"

    assert_text "Subject was successfully updated."
    click_on "Back"
  end

  test "destroying a Subject" do
    visit subjects_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Subject was successfully destroyed."
  end
end
