defmodule Skrap.Content.Manga do
  defstruct author: nil, cover_url: nil, id: nil, illustrator: nil, name: nil

  @type t :: %__MODULE__{
          author: String.t(),
          cover_url: String.t(),
          id: binary(),
          illustrator: String.t(),
          name: String.t()
        }
end
