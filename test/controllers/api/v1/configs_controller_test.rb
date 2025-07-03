require "test_helper"

class Api::V1::ConfigsControllerTest < BaseTest
  def test_should_set
    post api_v1_configs_set_url, params: { app: { name: "test", key_values:  [
      one: "one", two: "two"
    ] } }, headers: headers
    assert_response :success
  end

  def test_should_unset
    post api_v1_configs_unset_url, params: { app: { name: "test", keys: [ "test" ] } }, headers: headers
    assert_response :success
  end
end
