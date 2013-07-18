defmodule Docker.ConfigBase do
  defmacro __using__(app) do
    quote do
      def get(key) do
        case :application.get_env(unquote(app), key) do
          {:ok, {:from_env, env, default}} ->
            System.get_env(env) || default
          {:ok, value} ->
            value
          :undefined ->
            nil
        end
      end

      def set(key, value) do
        :application.set_env(unquote(app), key, value)
        value
      end
    end
  end
end
