# frozen_string_literal: true

require "test_helper"

class LayoutsTest < ActionDispatch::IntegrationTest
  test "rendering default layout" do
    get "/layout_default"
    assert_response :success

    assert_select('body[data-layout="application"]')
  end
  test "rendering global_for_action" do
    get "/global_for_action"
    assert_response :success

    assert_select('body[data-layout="global_for_action"]')
  end
  test "rendering explicit_in_action" do
    get "/explicit_in_action"
    assert_response :success

    assert_select('body[data-layout="explicit_in_action"]')
  end
  test "rendering disabled_in_action" do
    get "/disabled_in_action"
    assert_response :success

    assert_select('body', 0)
  end
  test "rendering with_content_for" do
    get "/with_content_for"
    assert_response :success

    assert_select('body[data-layout="with_content_for"]', "Foo: bar")
  end
end
