require "test_helper"

class Api::V1::DomainsControllerTest < BaseTest
  def test_should_add
    post api_v1_domains_add_url, params: { app: { name: "test", domain: "test.com" } }, headers: headers
    assert_response :success
  end

  def test_should_unset
    post api_v1_domains_remove_url, params: { app: { name: "test", domain: "test.com" } }, headers: headers
    assert_response :success
  end
end
