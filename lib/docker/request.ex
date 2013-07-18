defmodule Docker.Request do
  defmacro __using__(_opts) do
    quote do
      import :macros, unquote(__MODULE__)

      @root_endpoint ""
    end
  end

  @host quote(do: host // nil)
  @options quote(do: options // [])

  defmacro root_endpoint(url) do
    quote do
      @root_endpoint @root_endpoint <> unquote(url)
    end
  end

  defmacro entry(endpoint, url // nil) do
    func = :"#{endpoint}"
    url  = url || "/#{endpoint}"

    contents = quote do: (
      if host do
        options = Dict.put(options, :docker_host, host)
      end
      unquote(__MODULE__).request(:get, @root_endpoint <> unquote(url), "", [], options)
    )

    quote do
      args = [unquote(Macro.escape @host), unquote(Macro.escape @options)]
      def unquote(func), args, [], do:
        unquote(Macro.escape(contents, unquote: true))
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
