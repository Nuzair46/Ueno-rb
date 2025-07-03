require "test_helper"

class Api::V1::AppsControllerTest < BaseTest
  def test_should_create
    post api_v1_apps_create_url, params: { app: { name: "test" } }, headers: headers
    assert_response :success
  end

  def test_should_destroy
    post api_v1_apps_destroy_url, params: { app: { name: "test" } }, headers: headers
    assert_response :success
  end

  def test_should_rename
    post api_v1_apps_rename_url, params: { app: { name: "test", new_name: "new_test" } }, headers: headers
    assert_response :success
  end

  def test_should_get_urls
    mocked_result = "http://test.com\nhttp://test2.com\n"
    DokkuClientServiceMock.mock_execute_command([ true, mocked_result ])
    post api_v1_apps_urls_url, params: { app: { name: "test" } }, headers: headers
    assert_response :success
    assert_equal [ "http://test.com", "http://test2.com" ], response_body["urls"]
  end

  def test_should_error_if_api_token_is_invalid
    post api_v1_apps_create_url, params: { app: { name: "test" } }, headers: headers({ "X-Auth-Token" => "im_invalid" })
    assert_response :unauthorized
  end

  def test_should_return_error_for_dokku
    DokkuClientServiceMock.mock_execute_command([ false, "some error" ])
    post api_v1_apps_create_url, params: { app: { name: "test" } }, headers: headers
    assert_response :internal_server_error
  end
end
