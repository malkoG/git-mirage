require 'test_helper'

class SnippetsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get snippets_show_url
    assert_response :success
  end

  test "should get edit" do
    get snippets_edit_url
    assert_response :success
  end

end
