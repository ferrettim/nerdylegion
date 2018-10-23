require "application_system_test_case"

class SettingsTest < ApplicationSystemTestCase
  setup do
    @setting = settings(:one)
  end

  test "visiting the index" do
    visit settings_url
    assert_selector "h1", text: "Settings"
  end

  test "creating a Setting" do
    visit settings_url
    click_on "New Setting"

    fill_in "Description", with: @setting.description
    fill_in "Facebook", with: @setting.facebook
    fill_in "Favicon", with: @setting.favicon
    fill_in "Instagram", with: @setting.instagram
    fill_in "Keywords", with: @setting.keywords
    fill_in "Name", with: @setting.name
    fill_in "Patreon", with: @setting.patreon
    fill_in "Reddit", with: @setting.reddit
    fill_in "Twitch", with: @setting.twitch
    fill_in "Twitter", with: @setting.twitter
    click_on "Create Setting"

    assert_text "Setting was successfully created"
    click_on "Back"
  end

  test "updating a Setting" do
    visit settings_url
    click_on "Edit", match: :first

    fill_in "Description", with: @setting.description
    fill_in "Facebook", with: @setting.facebook
    fill_in "Favicon", with: @setting.favicon
    fill_in "Instagram", with: @setting.instagram
    fill_in "Keywords", with: @setting.keywords
    fill_in "Name", with: @setting.name
    fill_in "Patreon", with: @setting.patreon
    fill_in "Reddit", with: @setting.reddit
    fill_in "Twitch", with: @setting.twitch
    fill_in "Twitter", with: @setting.twitter
    click_on "Update Setting"

    assert_text "Setting was successfully updated"
    click_on "Back"
  end

  test "destroying a Setting" do
    visit settings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Setting was successfully destroyed"
  end
end
