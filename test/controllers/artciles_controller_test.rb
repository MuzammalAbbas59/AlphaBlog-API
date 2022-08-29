require "test_helper"

class ArtcilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artcile = artciles(:one)
  end

  test "should get index" do
    get artciles_url
    assert_response :success
  end

  test "should get new" do
    get new_artcile_url
    assert_response :success
  end

  test "should create artcile" do
    assert_difference("Artcile.count") do
      post artciles_url, params: { artcile: { description: @artcile.description, title: @artcile.title } }
    end

    assert_redirected_to artcile_url(Artcile.last)
  end

  test "should show artcile" do
    get artcile_url(@artcile)
    assert_response :success
  end

  test "should get edit" do
    get edit_artcile_url(@artcile)
    assert_response :success
  end

  test "should update artcile" do
    patch artcile_url(@artcile), params: { artcile: { description: @artcile.description, title: @artcile.title } }
    assert_redirected_to artcile_url(@artcile)
  end

  test "should destroy artcile" do
    assert_difference("Artcile.count", -1) do
      delete artcile_url(@artcile)
    end

    assert_redirected_to artciles_url
  end
end
