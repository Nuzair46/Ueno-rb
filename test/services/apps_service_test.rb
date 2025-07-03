# frozen_string_literal: true

require "test_helper"

class AppsServceTest < ActiveSupport::TestCase
  def setup
    @app_name = "test"
    @service = AppsService.new(@app_name)
  end

  def test_urls
    mocked_result = "http://test.com\nhttp://test2.com\n"
    DokkuClientServiceMock.mock_execute_command([ true, mocked_result ])
    urls = @service.urls
    assert_equal [ "http://test.com", "http://test2.com" ], urls
  end
end
