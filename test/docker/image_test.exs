Code.require_file "../test_helper.exs", __DIR__

defmodule DockerImageTest do
  use ExUnit.Case

  test "support get all" do
    result = Docker.Image.all
    assert 200 == result.status_code
    assert is_list(result.body)
  end
end
