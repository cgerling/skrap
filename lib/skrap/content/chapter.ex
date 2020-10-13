defmodule Skrap.Content.Chapter do
  defstruct added_at: nil, id: nil, name: nil, uri: nil

  @type t :: %__MODULE__{
          added_at: Date.t(),
          id: binary(),
          name: String.t(),
          uri: String.t()
        }
end
