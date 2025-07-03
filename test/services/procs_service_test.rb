# frozen_string_literal: true

require "test_helper"

class ProcsServceTest < ActiveSupport::TestCase
  def setup
    @app_name = "test"
    @service = ProcsService.new(@app_name)
  end

  def test_report
    DokkuClientServiceMock.mock_execute_command([ true, mocked_result ])
    report = @service.report
    assert_equal expected_output, report
  end

  private
    def mocked_result
      "=====> test ps information\n       Deployed:                      false\n       Processes:                     0\n       Ps can scale:                  true\n       Ps computed procfile path:     Procfile\n       Ps global procfile path:       Procfile\n       Ps procfile path:              \n       Ps restart policy:             on-failure:10\n       Restore:                       true\n       Running:                       false\n"
    end

    def expected_output
      { "deployed"=>"false", "processes"=>"0", "ps-can-scale"=>"true", "ps-computed-procfile-path"=>"Procfile", "ps-global-procfile-path"=>"Procfile", "ps-procfile-path"=>"", "ps-restart-policy"=>"on-failure:10", "restore"=>"true", "running"=>"false" }
    end
end
