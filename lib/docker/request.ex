defmodule Docker.Request do
  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__), only: :macros

      @root_endpoint ""
    end
  end

  defmacro root_endpoint(url) do
    quote do
      @root_endpoint @root_endpoint <> unquote(url)
    end
  end

  defmacro entry(endpoint, url // nil) do
    func   = :"#{endpoint}"
    url    = url || "/#{endpoint}"
    module = __MODULE__

    quote bind_quoted: binding do
      def unquote(func)(host // nil, options // []) do
        if host do
          options = Dict.put(options, :docker_host, host)
        end
        unquote(module).request(:get, @root_endpoint <> unquote(url), "", [], options)
      end
    end
  end

  def request(method, url, body // "", headers // [], options // []) do
    unless Dict.has_key?(headers, "Content-Type") do
      headers = Dict.put(headers, "Content-Type", "application/json")
    end

    host = options[:docker_host] || Docker.Config.get(:docker_host)
    url  = host <> url

    ## Clean
    options = Dict.delete(options, :docker_host)

    case HTTPotion.request(method, url, body, headers, options) do
      HTTPotion.Response[status_code: 200, body: body] = resp ->
        resp.body :jsx.decode(body)
      resp ->
        resp.body [ error: resp.body ]
    end
  end
end
