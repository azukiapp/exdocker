defmodule Docker.Container do
  use Docker.Request

  root_endpoint "/containers"

  entry :all, "/json"
end
