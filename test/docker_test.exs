Code.require_file "test_helper.exs", __DIR__

defmodule DockerTest do
  use ExUnit.Case

  test "support get version" do
    result = Docker.version
    assert 200 == result.status_code
    assert ListDict.has_key?(result.body, "Version")
    assert ListDict.has_key?(result.body, "GoVersion")
  end

  test "support get info" do
    result = Docker.info
    assert 200 == result.status_code
    assert ListDict.has_key?(result.body, "Debug")
    assert ListDict.has_key?(result.body, "Containers")
    assert ListDict.has_key?(result.body, "Images")
  end
end
