defmodule Docker.Image do
  use Docker.Request

  root_endpoint "/images"

  entry :all, "/json"
end
