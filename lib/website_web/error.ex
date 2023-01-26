defmodule WebsiteWeb.Error do
  defmodule NotFound do
    defexception([:message, plug_status: 404])
  end
end
