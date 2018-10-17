require "application_system_test_case"

class PrivaciesTest < ApplicationSystemTestCase
  setup do
    @privacy = privacies(:one)
  end

  test "visiting the index" do
    visit privacies_url
    assert_selector "h1", text: "Privacies"
  end

  test "creating a Privacy" do
    visit privacies_url
    click_on "New Privacy"

    fill_in "Description", with: @privacy.description
    fill_in "Title", with: @privacy.title
    click_on "Create Privacy"

    assert_text "Privacy was successfully created"
    click_on "Back"
  end

  test "updating a Privacy" do
    visit privacies_url
    click_on "Edit", match: :first

    fill_in "Description", with: @privacy.description
    fill_in "Title", with: @privacy.title
    click_on "Update Privacy"

    assert_text "Privacy was successfully updated"
    click_on "Back"
  end

  test "destroying a Privacy" do
    visit privacies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Privacy was successfully destroyed"
  end
end
