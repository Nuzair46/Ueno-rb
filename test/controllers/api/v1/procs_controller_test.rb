require "test_helper"

class Api::V1::ProcsControllerTest < BaseTest
  def test_should_rebuild
    post api_v1_procs_rebuild_url, params: { app: { name: "test" } }, headers: headers
    assert_response :success
  end

  def test_should_restart
    post api_v1_procs_restart_url, params: { app: { name: "test" } }, headers: headers
    assert_response :success
  end

  def test_should_scale
    post api_v1_procs_scale_url, params: { app: { name: "test" } }, headers: headers
    assert_response :success
  end

  def test_should_start
    post api_v1_procs_start_url, params: { app: { name: "test" } }, headers: headers
    assert_response :success
  end

  def test_should_stop
    post api_v1_procs_stop_url, params: { app: { name: "test" } }, headers: headers
    assert_response :success
  end

  def test_should_report
    post api_v1_procs_report_url, params: { app: { name: "test" } }, headers: headers
    assert_response :success
  end
end
