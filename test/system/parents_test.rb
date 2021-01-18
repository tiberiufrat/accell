require "application_system_test_case"

class ParentsTest < ApplicationSystemTestCase
  setup do
    @parent = parents(:one)
  end

  test "visiting the index" do
    visit parents_url
    assert_selector "h1", text: "Parents"
  end

  test "creating a Parent" do
    visit parents_url
    click_on "New Parent"

    fill_in "Family", with: @parent.family_id
    fill_in "Quality", with: @parent.quality
    click_on "Create Parent"

    assert_text "Parent was successfully created."
    click_on "Back"
  end

  test "updating a Parent" do
    visit parents_url
    click_on "Edit it", match: :first

    fill_in "Family", with: @parent.family_id
    fill_in "Quality", with: @parent.quality
    click_on "Update Parent"

    assert_text "Parent was successfully updated."
    click_on "Back"
  end

  test "destroying a Parent" do
    visit parents_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Parent was successfully destroyed."
  end
end
