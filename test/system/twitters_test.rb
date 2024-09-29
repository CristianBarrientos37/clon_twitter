require "application_system_test_case"

class TwittersTest < ApplicationSystemTestCase
  setup do
    @twitter = twitters(:one)
  end

  test "visiting the index" do
    visit twitters_url
    assert_selector "h1", text: "Twitters"
  end

  test "should create twitter" do
    visit twitters_url
    click_on "New twitter"

    fill_in "Description", with: @twitter.description
    fill_in "Username", with: @twitter.username
    click_on "Create Twitter"

    assert_text "Twitter was successfully created"
    click_on "Back"
  end

  test "should update Twitter" do
    visit twitter_url(@twitter)
    click_on "Edit this twitter", match: :first

    fill_in "Description", with: @twitter.description
    fill_in "Username", with: @twitter.username
    click_on "Update Twitter"

    assert_text "Twitter was successfully updated"
    click_on "Back"
  end

  test "should destroy Twitter" do
    visit twitter_url(@twitter)
    click_on "Destroy this twitter", match: :first

    assert_text "Twitter was successfully destroyed"
  end
end
