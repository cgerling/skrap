defmodule Skrap.Content.Manga do
  defstruct author: nil, chapters: [], cover_url: nil, id: nil, illustrator: nil, name: nil

  alias Skrap.Content.Chapter

  @type t :: %__MODULE__{
          author: String.t(),
          chapters: list(Chapter.t()),
          cover_url: String.t(),
          id: binary(),
          illustrator: String.t(),
          name: String.t()
        }
end
