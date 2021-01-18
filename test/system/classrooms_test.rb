require "application_system_test_case"

class ClassroomsTest < ApplicationSystemTestCase
  setup do
    @classroom = classrooms(:one)
  end

  test "visiting the index" do
    visit classrooms_url
    assert_selector "h1", text: "Classrooms"
  end

  test "creating a Classroom" do
    visit classrooms_url
    click_on "New Classroom"

    check_label "classroom_allow_registration" if @classroom.allow_registration
    fill_in "Color", with: @classroom.color
    fill_in "Form tutor", with: @classroom.form_tutor_id
    fill_in "Name", with: @classroom.name
    check_label "classroom_optional" if @classroom.optional
    fill_in "Registration code", with: @classroom.registration_code
    click_on "Create Classroom"

    assert_text "Classroom was successfully created."
    click_on "Back"
  end

  test "updating a Classroom" do
    visit classrooms_url
    click_on "Edit it", match: :first

    check_label "classroom_allow_registration" if @classroom.allow_registration
    fill_in "Color", with: @classroom.color
    fill_in "Form tutor", with: @classroom.form_tutor_id
    fill_in "Name", with: @classroom.name
    check_label "classroom_optional" if @classroom.optional
    fill_in "Registration code", with: @classroom.registration_code
    click_on "Update Classroom"

    assert_text "Classroom was successfully updated."
    click_on "Back"
  end

  test "destroying a Classroom" do
    visit classrooms_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Classroom was successfully destroyed."
  end
end
