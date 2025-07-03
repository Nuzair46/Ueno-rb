require "test_helper"

class BaseServiceTest < ActiveSupport::TestCase
  def setup
    @service = BaseService.new("test_app")
  end

  def test_execute_dokku_command_raises_error_on_failure
    DokkuClientServiceMock.mock_execute_command([ false, "some error" ])
    assert_raises(BaseService::DokkuCommandFailedError) do
      @service.execute_dokku_command("some_invalid_command")
    end
  end
end
