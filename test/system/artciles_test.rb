require "application_system_test_case"

class ArtcilesTest < ApplicationSystemTestCase
  setup do
    @artcile = artciles(:one)
  end

  test "visiting the index" do
    visit artciles_url
    assert_selector "h1", text: "Artciles"
  end

  test "should create artcile" do
    visit artciles_url
    click_on "New artcile"

    fill_in "Description", with: @artcile.description
    fill_in "Title", with: @artcile.title
    click_on "Create Artcile"

    assert_text "Artcile was successfully created"
    click_on "Back"
  end

  test "should update Artcile" do
    visit artcile_url(@artcile)
    click_on "Edit this artcile", match: :first

    fill_in "Description", with: @artcile.description
    fill_in "Title", with: @artcile.title
    click_on "Update Artcile"

    assert_text "Artcile was successfully updated"
    click_on "Back"
  end

  test "should destroy Artcile" do
    visit artcile_url(@artcile)
    click_on "Destroy this artcile", match: :first

    assert_text "Artcile was successfully destroyed"
  end
end
